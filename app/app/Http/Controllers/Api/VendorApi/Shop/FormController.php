<?php

namespace App\Http\Controllers\Api\VendorApi\Shop;

use App\Http\Controllers\Controller;
use App\Models\Form;
use App\Models\FormInput;
use App\Models\Language;
use Illuminate\Http\Request;
use Illuminate\Support\Collection;
use Illuminate\Support\Facades\Validator;

class FormController extends Controller
{
    private const VENDOR_FORM_TYPES = [
        'quote_request' => 'Quote Request',
    ];

    private const FORM_STATUSES = [
        'active' => [
            'label' => 'Active',
            'is_active' => true,
        ],
        'inactive' => [
            'label' => 'Inactive',
            'is_active' => false,
        ],
    ];

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
     * GET /api/vendor/shop/forms
     * Retrieve all forms for the authenticated vendor
     */
    public function index(Request $request)
    {
        $vendor = $request->user();
        $language = $this->resolveLanguage($request);
        $search = trim((string) $request->input('search', ''));
        $type = trim((string) $request->input('type', ''));
        $statusInput = $request->input('status');
        $page = max((int) $request->input('page', 1), 1);

        if ($type !== '' && !$this->isSupportedFormType($type)) {
            return response()->json([
                'errors' => [
                    'type' => ['The selected form type is invalid.'],
                ],
            ], 422);
        }

        $status = $statusInput === null || $statusInput === ''
            ? null
            : $this->normalizeStatus($statusInput);

        if ($statusInput !== null && $statusInput !== '' && $status === null) {
            return response()->json([
                'errors' => [
                    'status' => ['The selected status is invalid.'],
                ],
            ], 422);
        }

        $query = Form::query()
            ->with('language:id,name,code')
            ->withCount('input')
            ->where('vendor_id', $vendor->id)
            ->where('language_id', $language->id);

        if ($search !== '') {
            $query->where('name', 'like', '%' . $search . '%');
        }

        if ($type !== '') {
            $query->where('type', $type);
        }

        if ($status !== null) {
            $query->where('status', $status);
        }

        $forms = $query->orderByDesc('created_at')->paginate(10, ['*'], 'page', $page);

        return response()->json([
            'status' => 'success',
            'data' => [
                'forms' => collect($forms->items())
                    ->map(fn(Form $form) => $this->serializeForm($form))
                    ->values(),
                'pagination' => [
                    'total' => $forms->total(),
                    'per_page' => $forms->perPage(),
                    'current_page' => $forms->currentPage(),
                    'last_page' => $forms->lastPage(),
                ],
                'meta' => $this->meta(false, $language),
            ],
        ], 200);
    }

    /**
     * POST /api/vendor/shop/forms
     * Create a new form
     */
    public function store(Request $request)
    {
        $vendor = $request->user();

        $validator = Validator::make($request->all(), [
            'language_id' => 'required|integer|exists:languages,id',
            'name' => 'required|string|max:255',
            'status' => 'required',
            'type' => 'required|string',
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $type = trim((string) $request->input('type'));
        if (!$this->isSupportedFormType($type)) {
            return response()->json([
                'errors' => [
                    'type' => ['The selected form type is invalid.'],
                ],
            ], 422);
        }

        $status = $this->normalizeStatus($request->input('status'));
        if ($status === null) {
            return response()->json([
                'errors' => [
                    'status' => ['The selected status is invalid.'],
                ],
            ], 422);
        }

        $languageId = (int) $request->input('language_id');
        $name = trim((string) $request->input('name'));

        $existingForm = Form::query()
            ->where('vendor_id', $vendor->id)
            ->where('type', $type)
            ->where('language_id', $languageId)
            ->first();

        if ($existingForm) {
            return response()->json([
                'error' => 'A form of this type already exists for this language.',
            ], 422);
        }

        $form = Form::query()->create([
            'vendor_id' => $vendor->id,
            'language_id' => $languageId,
            'name' => $name,
            'status' => $status,
            'type' => $type,
        ]);

        $form->load('language:id,name,code')->loadCount('input');

        return response()->json([
            'status' => 'success',
            'message' => 'Form created successfully.',
            'data' => [
                'form' => $this->serializeForm($form),
                'meta' => $this->meta(false, $form->language),
            ],
        ], 201);
    }

    /**
     * GET /api/vendor/shop/forms/{id}
     * Retrieve a specific form with all its input fields
     */
    public function show(Request $request, $id)
    {
        $vendor = $request->user();

        $form = Form::query()
            ->with('language:id,name,code')
            ->withCount('input')
            ->with([
                'input' => fn($query) => $query->orderBy('order_no', 'asc'),
            ])
            ->where('vendor_id', $vendor->id)
            ->findOrFail($id);

        return response()->json([
            'status' => 'success',
            'data' => [
                'form' => $this->serializeForm($form, true),
                'meta' => $this->meta(true, $form->language),
            ],
        ], 200);
    }

    /**
     * PUT /api/vendor/shop/forms/{id}
     * Update an existing form
     */
    public function update(Request $request, $id)
    {
        $vendor = $request->user();

        $form = Form::query()
            ->where('vendor_id', $vendor->id)
            ->findOrFail($id);

        $validator = Validator::make($request->all(), [
            'language_id' => 'sometimes|integer|exists:languages,id',
            'name' => 'sometimes|string|max:255',
            'status' => 'sometimes',
            'type' => 'sometimes|string',
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $nextType = $request->has('type')
            ? trim((string) $request->input('type'))
            : $form->type;

        if (!$this->isSupportedFormType($nextType)) {
            return response()->json([
                'errors' => [
                    'type' => ['The selected form type is invalid.'],
                ],
            ], 422);
        }

        $status = $request->has('status')
            ? $this->normalizeStatus($request->input('status'))
            : null;

        if ($request->has('status') && $status === null) {
            return response()->json([
                'errors' => [
                    'status' => ['The selected status is invalid.'],
                ],
            ], 422);
        }

        $nextLanguageId = $request->has('language_id')
            ? (int) $request->input('language_id')
            : (int) $form->language_id;

        if ($nextType !== $form->type || $nextLanguageId !== (int) $form->language_id) {
            $existingForm = Form::query()
                ->where('vendor_id', $vendor->id)
                ->where('type', $nextType)
                ->where('language_id', $nextLanguageId)
                ->where('id', '!=', $form->id)
                ->first();

            if ($existingForm) {
                return response()->json([
                    'error' => 'A form of this type already exists for this language.',
                ], 422);
            }
        }

        $payload = [];

        if ($request->has('language_id')) {
            $payload['language_id'] = $nextLanguageId;
        }

        if ($request->has('name')) {
            $payload['name'] = trim((string) $request->input('name'));
        }

        if ($request->has('status')) {
            $payload['status'] = $status;
        }

        if ($request->has('type')) {
            $payload['type'] = $nextType;
        }

        if (!empty($payload)) {
            $form->update($payload);
        }

        $form->load('language:id,name,code')->loadCount('input');

        return response()->json([
            'status' => 'success',
            'message' => 'Form updated successfully.',
            'data' => [
                'form' => $this->serializeForm($form),
                'meta' => $this->meta(false, $form->language),
            ],
        ], 200);
    }

    /**
     * DELETE /api/vendor/shop/forms/{id}
     * Delete a form and all its input fields
     */
    public function destroy(Request $request, $id)
    {
        $vendor = $request->user();

        $form = Form::query()
            ->where('vendor_id', $vendor->id)
            ->findOrFail($id);

        $form->input()->delete();
        $form->delete();

        return response()->json([
            'status' => 'success',
            'message' => 'Form deleted successfully.',
        ], 200);
    }

    private function meta(bool $includeFieldTypes = false, ?Language $currentLanguage = null): array
    {
        $meta = [
            'languages' => Language::query()
                ->orderByDesc('is_default')
                ->orderBy('id')
                ->get(['id', 'name', 'code']),
            'form_types' => $this->vendorFormTypeOptions(),
            'statuses' => $this->formStatusOptions(),
            'current_language' => $currentLanguage
                ? [
                    'id' => (int) $currentLanguage->id,
                    'name' => $currentLanguage->name,
                    'code' => $currentLanguage->code,
                ]
                : null,
        ];

        if ($includeFieldTypes) {
            $meta['field_types'] = $this->inputTypeOptions();
        }

        return $meta;
    }

    private function vendorFormTypeOptions(): array
    {
        return collect(self::VENDOR_FORM_TYPES)
            ->map(fn(string $label, string $value) => [
                'value' => $value,
                'label' => $label,
            ])
            ->values()
            ->all();
    }

    private function formStatusOptions(): array
    {
        return collect(self::FORM_STATUSES)
            ->map(fn(array $status, string $value) => [
                'value' => $value,
                'label' => $status['label'],
                'is_active' => $status['is_active'],
            ])
            ->values()
            ->all();
    }

    private function inputTypeOptions(): array
    {
        return array_values(self::INPUT_TYPES);
    }

    private function serializeForm(Form $form, bool $includeInputs = false): array
    {
        $statusKey = $this->normalizeStatus($form->status) ?? 'inactive';
        $status = self::FORM_STATUSES[$statusKey] ?? self::FORM_STATUSES['inactive'];
        $type = (string) $form->type;
        $typeLabel = self::VENDOR_FORM_TYPES[$type] ?? $this->labelize($type);

        $payload = [
            'id' => (int) $form->id,
            'language_id' => (int) $form->language_id,
            'language_name' => $form->language?->name,
            'language_code' => $form->language?->code,
            'name' => $form->name,
            'type' => $type,
            'type_label' => $typeLabel,
            'status' => $status['is_active'] ? 1 : 0,
            'status_key' => $statusKey,
            'status_label' => $status['label'],
            'inputs_count' => isset($form->inputs_count)
                ? (int) $form->inputs_count
                : (int) $form->input()->count(),
            'created_at' => optional($form->created_at)->toIso8601String(),
        ];

        if ($includeInputs) {
            $payload['inputs'] = $form->relationLoaded('input')
                ? $this->serializeInputs($form->input)
                : [];
        }

        return $payload;
    }

    private function serializeInputs(Collection $inputs): array
    {
        return $inputs
            ->sortBy('order_no')
            ->values()
            ->map(fn(FormInput $input) => $this->serializeInput($input))
            ->all();
    }

    private function serializeInput(FormInput $input): array
    {
        $definition = self::INPUT_TYPES[(int) $input->type] ?? [
            'value' => 'text',
            'label' => 'Text Field',
            'requires_placeholder' => true,
            'requires_options' => false,
            'requires_file_size' => false,
        ];

        $options = [];
        if (is_string($input->options) && $input->options !== '') {
            $decoded = json_decode($input->options, true);
            $options = is_array($decoded) ? array_values($decoded) : [];
        } elseif (is_array($input->options)) {
            $options = array_values($input->options);
        }

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
            'options' => $options,
            'file_size' => $input->file_size !== null ? (int) $input->file_size : null,
            'order' => (int) $input->order_no,
            'created_at' => optional($input->created_at)->toIso8601String(),
        ];
    }

    private function normalizeStatus(mixed $value): ?string
    {
        if (is_bool($value)) {
            return $value ? 'active' : 'inactive';
        }

        $normalized = strtolower(trim((string) $value));

        return match ($normalized) {
            '1', 'true', 'active' => 'active',
            '0', 'false', 'inactive' => 'inactive',
            default => null,
        };
    }

    private function isSupportedFormType(string $type): bool
    {
        return array_key_exists($type, self::VENDOR_FORM_TYPES);
    }

    private function labelize(string $value): string
    {
        return collect(explode('_', $value))
            ->filter(fn(string $part) => $part !== '')
            ->map(fn(string $part) => ucfirst(strtolower($part)))
            ->implode(' ');
    }

    private function resolveLanguage(Request $request): Language
    {
        $requestedCode = trim((string) $request->input('language', ''));
        $localeCode = trim((string) app()->getLocale());

        return Language::query()
            ->when(
                $requestedCode !== '',
                fn($query) => $query->where('code', $requestedCode),
                fn($query) => $query->where('code', $localeCode)
            )
            ->first()
            ?? Language::query()
                ->where('is_default', 1)
                ->firstOrFail();
    }
}
