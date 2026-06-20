<?php

namespace App\Http\Controllers\Vendor;

use App\Http\Controllers\Controller;
use App\Http\Requests\FormInput\StoreFormInputRequest;
use App\Http\Requests\FormInput\UpdateFormInputRequest;
use App\Models\Form;
use App\Models\FormInput;
use App\Models\Language;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\App;
use Illuminate\Support\Facades\Response;

class FormInputController extends Controller
{
    public function manageInput($id, Request $request)
    {
        $language = Language::where('code', '=', $request->language)->firstOrFail();

        $vendorId = auth()->guard('vendor')->id();
        $form = Form::where('vendor_id', $vendorId)->findOrFail($id);

        $inputFields = $form->input()->orderBy('order_no', 'asc')->get();


        return view('vendors.shop.form-input.index', [
            'language' => $language,
            'form' => $form,
            'inputFields' => $inputFields,
        ]);
    }

    public function storeInput(StoreFormInputRequest $request, $id)
    {
        $vendorId = auth()->guard('vendor')->id();
        $form = Form::where('vendor_id', $vendorId)->findOrFail($id);

        $inputName = createInputName($request['label']);
        $orderNo = FormInput::where('form_id', $id)->max('order_no');

        FormInput::create($request->except('form_id', 'name', 'options', 'order_no') + [
            'form_id' => $id,
            'name' => $inputName,
            'options' => $request->filled('options') ? json_encode($request['options']) : NULL,
            'order_no' => is_null($orderNo) ? 1 : ($orderNo + 1),
        ]);

        $request->session()->flash('success', __('Input field added successfully') . '!');
        return response()->json(['status' => 'success'], 200);
    }

    public function editInput(Request $request, $form_id, $input_id)
    {
        $vendorId = auth()->guard('vendor')->id();
        $form = Form::where('vendor_id', $vendorId)->findOrFail($form_id);

        $applange = App::getLocale();
        $langPart = explode('_', $applange);
        $language = Language::where('code', '=', $langPart[1])->firstOrFail();

        $inputField = FormInput::where('form_id', $form_id)->find($input_id);

        return view('vendors.shop.form-input.edit', [
            'language' => $language,
            'form' => $form,
            'inputField' => $inputField,
            'options' => !is_null($inputField->options) ? json_decode($inputField->options) : [],
        ]);
    }

    public function updateInput(UpdateFormInputRequest $request, $id)
    {
        $vendorId = auth()->guard('vendor')->id();
        $formInput = FormInput::findOrFail($id);
        $form = Form::where('vendor_id', $vendorId)->findOrFail($formInput->form_id);

        $inputName = createInputName($request['label']);

        $formInput->update($request->except('name', 'options') + [
            'name' => $inputName,
            'options' => $request->filled('options') ? json_encode($request['options']) : NULL,
        ]);

        $request->session()->flash('success', __('Input field updated successfully') . '!');
        return response()->json(['status' => 'success'], 200);
    }

    public function destroyInput($id, Request $request)
    {
        $vendorId = auth()->guard('vendor')->id();
        $formInput = FormInput::findOrFail($id);
        $form = Form::where('vendor_id', $vendorId)->findOrFail($formInput->form_id);

        $formInput->delete();

        return redirect()->back()->with('success', __('Input Field deleted successfully') . '!');
    }

    public function sortInput(Request $request)
    {
        $vendorId = auth()->guard('vendor')->id();
        $ids = $request['ids'];
        $orders = $request['orders'];

        for ($i = 0; $i < sizeof($ids); $i++) {
            $inputField = FormInput::find($ids[$i]);
            if ($inputField && $inputField->form->vendor_id == $vendorId) {
                $inputField->update([
                    'order_no' => $orders[$i],
                ]);
            }
        }

        return Response::json([
            'status' => __('Input fields sorted successfully') . '.',
        ], 200);
    }
}
