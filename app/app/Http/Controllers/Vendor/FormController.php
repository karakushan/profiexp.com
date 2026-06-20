<?php

namespace App\Http\Controllers\Vendor;

use App;
use App\Http\Controllers\Controller;
use App\Models\Form;
use App\Models\Language;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Response;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rule;

class FormController extends Controller
{
    public function index(Request $request)
    {
        $applange = App::getLocale();

        $langPart = explode('_', $applange);
        $language = Language::where('code', $langPart[1])->firstOrFail();

        $vendorId = auth()->guard('vendor')->id(); 
        $name = $request->input('name', null);

        $forms = $language->form()
            ->where('vendor_id', $vendorId)
            ->when($name, function ($query) use ($name) {
                return $query->where('name', 'like', '%' . $name . '%');
            })
            ->orderByDesc('id')
            ->paginate(10);

        return view('vendors.shop.form.index', [
            'language' => $language,
            'forms' => $forms,
            'langs' => Language::all(),
        ]);
    }

    public function store(Request $request)
    {
        $vendorId = auth()->guard('vendor')->id();

        $rules = [
            'language_id' => ['required', 'integer', 'exists:languages,id'],
            'name'        => ['required'],
            'status'      => ['required'],
            'type'        => ['required', Rule::in(['quote_request'])],
            'vendor_id'   => ['nullable', 'integer', 'exists:vendors,id'],
        ];

        $rules['vendor_id'][] = Rule::in([$vendorId]);

        if ($request->input('type') === 'quote_request') {
            $rules['type'][] = Rule::unique('forms', 'type')
                ->where(
                    fn($q) => $q
                        ->where('vendor_id', $vendorId)
                        ->where('language_id', $request->input('language_id'))
                );
        }

        $messages = [
            'type.unique' => __('A form of this type already exists for this scope') . '.',
        ];

        $validator = Validator::make(array_merge($request->all(), ['vendor_id' => $vendorId]), $rules, $messages);

        if ($validator->fails()) {
            return Response::json(['errors' => $validator->getMessageBag()], 422);
        }

        Form::create($request->only(['language_id', 'name', 'status', 'type']) + ['vendor_id' => $vendorId]);

        $request->session()->flash('success', __('Form added successfully') . '!');
        return Response::json(['status' => 'success'], 200);
    }

    public function update(Request $request)
    {
        $vendorId = auth()->guard('vendor')->id();
        $form = Form::where('vendor_id', $vendorId)->findOrFail($request->input('id'));

        $rules = [
            'name'       => ['required'],
            'status'     => ['required'],
            'type'       => ['required', Rule::in(['quote_request'])],
            'vendor_id'  => ['nullable', 'integer', 'exists:vendors,id'],
        ];

        $rules['vendor_id'][] = Rule::in([$vendorId]);

        if ($request->input('type') === 'quote_request') {
            $rules['type'][] = Rule::unique('forms', 'type')
                ->where(function ($q) use ($vendorId, $form) {
                    $q->where('language_id', $form->language_id)
                        ->where('vendor_id', $vendorId);
                })
                ->ignore($form->id);
        }

        $messages = [
            'type.unique' => __('A form of this type already exists for this scope') . '.',
        ];

        $validator = Validator::make(array_merge($request->all(), ['vendor_id' => $vendorId]), $rules, $messages);

        if ($validator->fails()) {
            return Response::json(['errors' => $validator->getMessageBag()], 422);
        }

        $form->update([
            'language_id' => $form->language_id,
            'name'        => $request->input('name'),
            'status'      => $request->input('status'),
            'type'        => $request->input('type'),
            'vendor_id'   => $vendorId,
        ]);

        $request->session()->flash('success', __('Form updated successfully') . '!');
        return Response::json(['status' => 'success'], 200);
    }

    public function destroy($id, Request $request)
    {
        $vendorId = auth()->guard('vendor')->id();
        $form = Form::where('vendor_id', $vendorId)->find($id);

        if (!$form) {
            $request->session()->flash('error', __('Form not found') . '!');
            return redirect()->back();
        }

        $inputFields = $form->input()->get();

        if (count($inputFields) > 0) {
            foreach ($inputFields as $inputField) {
                $inputField->delete();
            }
        }

        $form->delete();

        $request->session()->flash('success', __('Form deleted successfully') . '!');
        return redirect()->back();
    }
}
