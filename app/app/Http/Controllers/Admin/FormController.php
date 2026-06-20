<?php

namespace App\Http\Controllers\Admin;

use App;
use App\Http\Controllers\Controller;
use App\Models\Form;
use App\Models\Language;
use App\Models\Vendor;
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
    $language = Language::query()->where('code', '=', $langPart[1])->firstOrFail();
  
    $information['language'] = $language;

    $information['sellers'] = Vendor::select('username', 'id')->where('id', '!=', 0)->get();
    $seller = $name = null;


    if ($request->filled('seller')) {
      $seller = $request->seller;
    }
    if ($request->filled('name')) {
      $name = $request->name;
    }


    $information['forms'] = $language->form()
      ->when($seller, function ($query) use ($seller) {
        if ($seller == 'admin') {
          $seller_id = null;
        } else {
          $seller_id = $seller;
        }
        return $query->where('vendor_id', $seller_id);
      })
      ->when($name, function ($query) use ($name){
        return $query->where('name', 'like', '%' . $name . '%');
      })
      ->orderByDesc('id')->paginate(10);

    $information['langs'] = Language::all();

    return view('admin.listing.form.index', $information);
  }

  public function store(Request $request)
  {
    $rules = [
      'language_id' => ['required', 'integer', 'exists:languages,id'],
      'name'        => ['required'],
      'status'      => ['required'],
      'type'        => ['required', Rule::in(['quote_request', 'claim_request'])],
      'vendor_id'   => ['nullable', 'integer', 'exists:vendors,id'],
    ];

    if ($request->input('type') === 'quote_request') {
      $rules['type'][] = Rule::unique('forms', 'type')
        ->where(
          fn($q) => $q
            ->where('vendor_id', $request->input('vendor_id'))   
            ->where('language_id', $request->input('language_id')) 
        );
    }

    if ($request->input('type') === 'claim_request') {

      $rules['vendor_id'][] = 'prohibited'; 
      $rules['type'][] = Rule::unique('forms', 'type')->where(function ($q) use ($request) {
        $q->where('language_id', $request->input('language_id'))
          ->whereNull('vendor_id'); 
      });
    }

    $messages = [
      'type.unique' => __('A form of this type already exists for this scope') . '.',
    ];

    $validator = Validator::make($request->all(), $rules, $messages);

    if ($validator->fails()) {
      return Response::json(['errors' => $validator->getMessageBag()], 422);
    }

    Form::create($request->all());

    $request->session()->flash('success', __('Form added successfully') . '!');
    return Response::json(['status' => 'success'], 200);
  }

  // public function update(Request $request)
  // {
  //   $rule = [
  //     'name' => 'required',
  //     'status' => 'required'
  //   ];

  //   $validator = Validator::make($request->all(), $rule);

  //   if ($validator->fails()) {
  //     return Response::json([
  //       'errors' => $validator->getMessageBag()
  //     ], 400);
  //   }

  //   $form = Form::query()->find($request['id']);

  //   $form->update($request->all());

  //   $request->session()->flash('success', __('Form updated successfully') . '!');

  //   return Response::json(['status' => 'success'], 200);
  // }
  // public function update(Request $request)
  // {
  //   // Define base validation rules, similar to store but adapted for update
  //   $rules = [
  //     'name' => ['required'],
  //     'status' => ['required'], 
  //     'type' => ['required', Rule::in(['quote_request'])],
  //     'vendor_id' => ['nullable', 'integer', 'exists:vendors,id'],
  //   ];

  //   // Add unique rule for 'quote_request' type, excluding current record
  //   if ($request->input('type') === 'quote_request') {
  //     $rules['type'][] = Rule::unique('forms', 'type')
  //       ->where(function ($query) use ($request) {
  //         $query->where('vendor_id', $request->input('vendor_id'))
  //           ->where('language_id', $request->input('language_id'));
  //       })
  //       ->ignore($request->input('id')); 
  //   }

  //   // Custom error messages
  //   $messages = [
  //     'type.unique' => __('A quote request form already exists for this vendor in this language') . '.',
  //   ];

  //   // Validate the request
  //   $validator = Validator::make($request->all(), $rules, $messages);

  //   if ($validator->fails()) {
  //     return Response::json(['errors' => $validator->getMessageBag()], 422); 
  //   }

  //   // Find the form to update
  //   $form = Form::findOrFail($request->input('id'));

  //   // Update only the validated fields (avoids mass assignment issues)
  //   $form->update([
  //     'language_id' => $form->language_id,
  //     'name' => $request->input('name'),
  //     'status' => $request->input('status'),
  //     'type' => $request->input('type'),
  //     'vendor_id' => $request->input('vendor_id'),
  //   ]);

  //   // Flash success message
  //   $request->session()->flash('success', __('Form updated successfully') . '!');

  //   // Return success response
  //   return Response::json(['status' => 'success'], 200);
  // }
  public function update(Request $request)
  {
    // Load the target form; keep its language_id fixed during update
    $form = Form::findOrFail($request->input('id'));

    $rules = [
      'name'       => ['required'],                 
      'status'     => ['required'],                 
      'type'       => ['required', Rule::in(['quote_request', 'claim_request'])], 
      'vendor_id'  => ['nullable', 'integer', 'exists:vendors,id'], 
    ];

    // Type-specific constraints
    if ($request->input('type') === 'quote_request') {

      $rules['type'][] = Rule::unique('forms', 'type')
        ->where(function ($q) use ($request, $form) {
          $q->where('language_id', $form->language_id) 
            ->where('vendor_id', $request->input('vendor_id')); 
        })
        ->ignore($form->id); 
    }

    if ($request->input('type') === 'claim_request') {

      $rules['vendor_id'][] = 'prohibited';


      $rules['type'][] = Rule::unique('forms', 'type')
        ->where(function ($q) use ($form) {
          $q->where('language_id', $form->language_id)
            ->whereNull('vendor_id');
        })
        ->ignore($form->id); 
    }

    $messages = [
      'type.unique'          => __('A form of this type already exists for this scope') . '.',  
    ];

    $validator = Validator::make($request->all(), $rules, $messages); 

    if ($validator->fails()) {
      return Response::json(['errors' => $validator->getMessageBag()], 422); 
    }

 
    $form->update([
      'language_id' => $form->language_id,                 
      'name'        => $request->input('name'),
      'status'      => $request->input('status'),
      'type'        => $request->input('type'),
      'vendor_id'   => $request->input('type') === 'claim_request' ? null : $request->input('vendor_id'),
    ]);

    $request->session()->flash('success', __('Form updated successfully') . '!'); 
    return Response::json(['status' => 'success'], 200); 
  }

  public function destroy($id, Request $request)
  {
 
    $form = Form::query()->find($id);
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
