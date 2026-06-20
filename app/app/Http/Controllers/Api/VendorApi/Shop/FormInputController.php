<?php

namespace App\Http\Controllers\Api\VendorApi\Shop;

use App\Http\Controllers\Controller;
use App\Models\Form;
use App\Models\FormInput;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class FormInputController extends Controller
{
    private const INPUT_TYPES = [
        1 => [
            'value' => 'text',
            'label' => 'Text Field',
            'requires_placeholder' => true,
            'requires_options' => false,
            'requires_file_size' => false,
        ],
        2 => [
            'value' => 'number',
            'label' => 'Number Field',
            'requires_placeholder' => true,
            'requires_options' => false,
            'requires_file_size' => false,
        ],
        3 => [
            'value' => 'select',
            'label' => 'Select',
            'requires_placeholder' => true,
            'requires_options' => true,
            'requires_file_size' => false,
        ],
        4 => [
            'value' => 'checkbox',
            'label' => 'Checkbox',
            'requires_placeholder' => false,
            'requires_options' => true,
            'requires_file_size' => false,
        ],
        5 => [
            'value' => 'textarea',
            'label' => 'Textarea',
            'requires_placeholder' => true,
            'requires_options' => false,
            'requires_file_size' => false,
        ],
        6 => [
            'value' => 'date',
            'label' => 'Datepicker',
            'requires_placeholder' => true,
            'requires_options' => false,
            'requires_file_size' => false,
        ],
        7 => [
            'value' => 'time',
            'label' => 'Timepicker',
            'requires_placeholder' => true,
            'requires_options' => false,
            'requires_file_size' => false,
        ],
        8 => [
            'value' => 'file',
            'label' => 'File',
            'requires_placeholder' => false,
            'requires_options' => false,
            'requires_file_size' => true,
            'default_file_size' => 10,
        ],
    ];

    /**
     * GET /api/vendor/shop/forms/{formId}/inputs
     * Retrieve all input fields for a specific form
     */
    public function index(Request $request, $formId)
    {
        $vendor = $request->user();

        $form = Form::query()
            ->where('vendor_id', $vendor->id)
            ->findOrFail($formId);

        $inputs = $form->input()
            ->orderBy('order_no', 'asc')
            ->get()
            ->map(fn(FormInput $input) => $this->serializeInput($input))
            ->values();

        return response()->json([
            'status' => 'success',
            'data' => [
                'form_id' => (int) $form->id,
                'form_name' => $form->name,
                'inputs' => $inputs,
                'meta' => [
                    'field_types' => $this->inputTypeOptions(),
                ],
            ],
        ], 200);
    }

    /**
     * POST /api/vendor/shop/forms/{formId}/inputs
     * Create a new input field for a form
     */
    public function store(Request $request, $formId)
    {
        $vendor = $request->user();

        $form = Form::query()
            ->where('vendor_id', $vendor->id)
            ->findOrFail($formId);

        $validator = Validator::make($request->all(), [
            'label' => 'required|string|max:255',
            'field_type' => 'nullable',
            'type' => 'nullable',
            'is_required' => 'sometimes|boolean',
            'placeholder' => 'nullable|string|max:255',
            'options' => 'sometimes|array',
            'options.*' => 'nullable|string|max:255',
            'file_size' => 'nullable|numeric|min:1',
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $typeCode = $this->parseInputType(
            $request->input('field_type', $request->input('type'))
        );

        if ($typeCode === null) {
            return response()->json([
                'errors' => [
                    'field_type' => ['The selected field type is invalid.'],
                ],
            ], 422);
        }

        $definition = self::INPUT_TYPES[$typeCode];
        $label = trim((string) $request->input('label'));
        $inputName = $this->createInputName($label);

        $existingInput = FormInput::query()
            ->where('form_id', $formId)
            ->where('name', $inputName)
            ->first();

        if ($existingInput) {
            return response()->json([
                'error' => 'The input field already exists.',
            ], 422);
        }

        $placeholder = $this->normalizeText($request->input('placeholder'));
        $options = $this->normalizeOptions($request->input('options', []));
        $fileSize = $this->normalizeFileSize(
            $request->input('file_size'),
            $definition
        );

        $validationErrors = $this->validateInputPayload(
            $definition,
            $placeholder,
            $options,
            $fileSize
        );

        if (!empty($validationErrors)) {
            return response()->json(['errors' => $validationErrors], 422);
        }

        $orderNo = FormInput::query()->where('form_id', $formId)->max('order_no');

        $input = FormInput::query()->create([
            'form_id' => $formId,
            'type' => $typeCode,
            'label' => $label,
            'placeholder' => $definition['requires_placeholder'] ? $placeholder : null,
            'name' => $inputName,
            'is_required' => $request->boolean('is_required', false),
            'options' => $definition['requires_options'] ? json_encode($options) : null,
            'file_size' => $definition['requires_file_size'] ? $fileSize : null,
            'order_no' => is_null($orderNo) ? 1 : ($orderNo + 1),
        ]);

        return response()->json([
            'status' => 'success',
            'message' => 'Input field created successfully.',
            'data' => [
                'input' => $this->serializeInput($input),
                'meta' => [
                    'field_types' => $this->inputTypeOptions(),
                ],
            ],
        ], 201);
    }

    /**
     * GET /api/vendor/shop/inputs/{inputId}
     * Retrieve a specific input field
     */
    public function show(Request $request, $inputId)
    {
        $vendor = $request->user();

        $input = FormInput::query()->findOrFail($inputId);
        Form::query()
            ->where('vendor_id', $vendor->id)
            ->findOrFail($input->form_id);

        return response()->json([
            'status' => 'success',
            'data' => [
                'input' => $this->serializeInput($input),
                'meta' => [
                    'field_types' => $this->inputTypeOptions(),
                ],
            ],
        ], 200);
    }

    /**
     * PUT /api/vendor/shop/inputs/{inputId}
     * Update an input field
     */
    public function update(Request $request, $inputId)
    {
        $vendor = $request->user();

        $input = FormInput::query()->findOrFail($inputId);
        Form::query()
            ->where('vendor_id', $vendor->id)
            ->findOrFail($input->form_id);

        $validator = Validator::make($request->all(), [
            'label' => 'sometimes|string|max:255',
            'field_type' => 'nullable',
            'type' => 'nullable',
            'is_required' => 'sometimes|boolean',
            'placeholder' => 'nullable|string|max:255',
            'options' => 'sometimes|array',
            'options.*' => 'nullable|string|max:255',
            'file_size' => 'nullable|numeric|min:1',
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $typeCode = $request->has('field_type') || $request->has('type')
            ? $this->parseInputType($request->input('field_type', $request->input('type')))
            : (int) $input->type;

        if ($typeCode === null || !isset(self::INPUT_TYPES[$typeCode])) {
            return response()->json([
                'errors' => [
                    'field_type' => ['The selected field type is invalid.'],
                ],
            ], 422);
        }

        $definition = self::INPUT_TYPES[$typeCode];
        $label = $request->has('label')
            ? trim((string) $request->input('label'))
            : $input->label;
        $inputName = $this->createInputName($label);

        $existingInput = FormInput::query()
            ->where('form_id', $input->form_id)
            ->where('name', $inputName)
            ->where('id', '!=', $input->id)
            ->first();

        if ($existingInput) {
            return response()->json([
                'error' => 'The input field already exists.',
            ], 422);
        }

        $placeholder = $request->has('placeholder')
            ? $this->normalizeText($request->input('placeholder'))
            : $this->normalizeText($input->placeholder);

        $options = $request->has('options')
            ? $this->normalizeOptions($request->input('options', []))
            : $this->decodeOptions($input->options);

        $fileSize = $request->has('file_size')
            ? $this->normalizeFileSize($request->input('file_size'), $definition)
            : ($input->file_size !== null ? (int) $input->file_size : null);

        if ($definition['requires_file_size'] && $fileSize === null) {
            $fileSize = $this->normalizeFileSize(null, $definition);
        }

        $validationErrors = $this->validateInputPayload(
            $definition,
            $placeholder,
            $options,
            $fileSize
        );

        if (!empty($validationErrors)) {
            return response()->json(['errors' => $validationErrors], 422);
        }

        $input->update([
            'type' => $typeCode,
            'label' => $label,
            'placeholder' => $definition['requires_placeholder'] ? $placeholder : null,
            'name' => $inputName,
            'is_required' => $request->has('is_required')
                ? $request->boolean('is_required')
                : (bool) $input->is_required,
            'options' => $definition['requires_options'] ? json_encode($options) : null,
            'file_size' => $definition['requires_file_size'] ? $fileSize : null,
        ]);

        $input->refresh();

        return response()->json([
            'status' => 'success',
            'message' => 'Input field updated successfully.',
            'data' => [
                'input' => $this->serializeInput($input),
                'meta' => [
                    'field_types' => $this->inputTypeOptions(),
                ],
            ],
        ], 200);
    }

    /**
     * DELETE /api/vendor/shop/inputs/{inputId}
     * Delete an input field
     */
    public function destroy(Request $request, $inputId)
    {
        $vendor = $request->user();

        $input = FormInput::query()->findOrFail($inputId);
        Form::query()
            ->where('vendor_id', $vendor->id)
            ->findOrFail($input->form_id);

        $input->delete();

        return response()->json([
            'status' => 'success',
            'message' => 'Input field deleted successfully.',
        ], 200);
    }

    /**
     * PUT /api/vendor/shop/forms/{formId}/inputs/reorder
     * Reorder input fields
     */
    public function reorder(Request $request, $formId)
    {
        $vendor = $request->user();

        Form::query()
            ->where('vendor_id', $vendor->id)
            ->findOrFail($formId);

        $validator = Validator::make($request->all(), [
            'inputs' => 'required|array',
            'inputs.*.id' => 'required|integer',
            'inputs.*.order' => 'required|integer|min:1',
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        foreach ($request->input('inputs') as $item) {
            $input = FormInput::query()
                ->where('form_id', $formId)
                ->find($item['id']);

            if ($input) {
                $input->update(['order_no' => $item['order']]);
            }
        }

        return response()->json([
            'status' => 'success',
            'message' => 'Input fields reordered successfully.',
        ], 200);
    }

    private function inputTypeOptions(): array
    {
        return array_values(self::INPUT_TYPES);
    }

    private function parseInputType(mixed $raw): ?int
    {
        if ($raw === null || $raw === '') {
            return null;
        }

        if (is_numeric($raw)) {
            $type = (int) $raw;
            return isset(self::INPUT_TYPES[$type]) ? $type : null;
        }

        $normalized = strtolower(trim((string) $raw));

        foreach (self::INPUT_TYPES as $type => $definition) {
            if ($definition['value'] === $normalized) {
                return $type;
            }
        }

        return null;
    }

    private function serializeInput(FormInput $input): array
    {
        $definition = self::INPUT_TYPES[(int) $input->type] ?? self::INPUT_TYPES[1];

        return [
            'id' => (int) $input->id,
            'form_id' => (int) $input->form_id,
            'name' => $input->name,
            'label' => $input->label,
            'field_type' => $definition['value'],
            'field_type_label' => $definition['label'],
            'db_type' => (int) $input->type,
            'is_required' => (bool) $input->is_required,
            'placeholder' => $input->placeholder,
            'options' => $this->decodeOptions($input->options),
            'file_size' => $input->file_size !== null ? (int) $input->file_size : null,
            'order' => (int) $input->order_no,
            'created_at' => optional($input->created_at)->toIso8601String(),
        ];
    }

    private function validateInputPayload(
        array $definition,
        ?string $placeholder,
        array $options,
        ?int $fileSize
    ): array {
        $errors = [];

        if ($definition['requires_placeholder'] && ($placeholder === null || $placeholder === '')) {
            $errors['placeholder'] = [
                'The placeholder field is required unless input type is checkbox or file.',
            ];
        }

        if ($definition['requires_options'] && empty($options)) {
            $errors['options'] = [
                'The options are required when input type is select or checkbox.',
            ];
        }

        if ($definition['requires_file_size'] && $fileSize === null) {
            $errors['file_size'] = [
                'The file size field is required when input type is file.',
            ];
        }

        return $errors;
    }

    private function normalizeOptions(mixed $options): array
    {
        if (!is_array($options)) {
            return [];
        }

        return collect($options)
            ->map(fn($option) => trim((string) $option))
            ->filter(fn(string $option) => $option !== '')
            ->values()
            ->all();
    }

    private function decodeOptions(mixed $options): array
    {
        if (is_array($options)) {
            return array_values($options);
        }

        if (is_string($options) && $options !== '') {
            $decoded = json_decode($options, true);
            return is_array($decoded) ? array_values($decoded) : [];
        }

        return [];
    }

    private function normalizeText(mixed $value): ?string
    {
        if ($value === null) {
            return null;
        }

        $text = trim((string) $value);
        return $text === '' ? null : $text;
    }

    private function normalizeFileSize(mixed $value, array $definition): ?int
    {
        if ($value === null || $value === '') {
            return $definition['requires_file_size']
                ? (int) ($definition['default_file_size'] ?? 10)
                : null;
        }

        return max(1, (int) ceil((float) $value));
    }

    /**
     * Helper method to generate input name from label
     */
    private function createInputName($label)
    {
        return strtolower(
            preg_replace('/[^a-zA-Z0-9_]/', '_', trim($label))
        );
    }
}
