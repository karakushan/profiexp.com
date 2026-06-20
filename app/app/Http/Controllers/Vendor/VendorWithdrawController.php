<?php

namespace App\Http\Controllers\Vendor;

use App\Http\Controllers\Controller;
use App\Models\Vendor;
use App\Models\Withdraw;
use App\Models\WithdrawMethodInput;
use App\Models\WithdrawPaymentMethod;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Response;
use Illuminate\Support\Facades\Session;
use Illuminate\Support\Facades\Validator;
use App\Services\VendorNotificationService;

class VendorWithdrawController extends Controller
{
    public function index()
    {
        $collection = Withdraw::with('method')->where('vendor_id', Auth::guard('vendor')->user()->id)->orderby('id', 'desc')->paginate(10);
        return view('vendors.withdraw.index', compact('collection'));
    }
    //create
    public function create()
    {
        $information = [];
        $methods = WithdrawPaymentMethod::where('status', '=', 1)->get();
        $information['methods'] = $methods;
        return view('vendors.withdraw.create', $information);
    }
    //get_inputs
    public function get_inputs($id)
    {
        $data = WithdrawMethodInput::with('options')->where('withdraw_payment_method_id', $id)->orderBy('order_number', 'asc')->get();

        return $data;
    }
    //balance_calculation
    public function balance_calculation($method, $amount)
    {
        $method = WithdrawPaymentMethod::where('id', $method)->first();
        $fixed_charge = $method->fixed_charge;
        $percentage = $method->percentage_charge;

        $percentage_balance = (($amount - $fixed_charge) * $percentage) / 100;
        $total_charge = $percentage_balance + $fixed_charge;
        $receive_balance = $amount - $total_charge;
        $user_balance = Auth::guard('vendor')->user()->amount - $amount;

        return ['total_charge' => round($total_charge, 2), 'receive_balance' => round($receive_balance, 2), 'user_balance' => round($user_balance, 2)];
    }

    //send_request
    public function send_request(Request $request)
    {
        $method = WithdrawPaymentMethod::where('id', $request->withdraw_method)->first();
        $vendor = Vendor::where('id', Auth::guard('vendor')->user()->id)->first();

        if (!$request->withdraw_method) {
            return Response::json(
                [
                    'errors' => [
                        'withdraw_method' => [
                            __('Withdraw Method field is required')
                        ]
                    ]
                ],
                400
            );
        } elseif (intval($request->withdraw_amount) < $method->min_limit) {
            return Response::json(
                [
                    'errors' => [
                        'withdraw_amount' => [
                            __('Minimum withdraw limit is') . ' ' . $method->min_limit
                        ]
                    ]
                ],
                400
            );
        } elseif (intval($request->withdraw_amount) > $method->max_limit) {
            return Response::json(
                [
                    'errors' => [
                        'withdraw_amount' => [
                            __('Maximum withdraw limit is') . ' ' . $method->max_limit
                        ]
                    ]
                ],
                400
            );
        }

        $rules = [
            'withdraw_method' => 'required',
            'withdraw_amount' => "required",
        ];
        $inputs = WithdrawMethodInput::where('withdraw_payment_method_id', $request->withdraw_method)->orderBy('order_number', 'asc')->get();

        $fields = [];
        foreach ($inputs as $input) {
            if ($input->required == 1) {
                $rules["$input->name"] = 'required';
            }
            foreach ($inputs as $key => $input) {
                $in_name = $input->name;
                if ($request["$in_name"]) {
                    $fields["$in_name"] = $request["$in_name"];
                }
            }
            $jsonfields = json_encode($fields);
            $jsonfields = str_replace("\/", "/", $jsonfields);;
        }

        $validator = Validator::make($request->all(), $rules);

        if ($validator->fails()) {
            return Response::json([
                'errors' => $validator->getMessageBag()
            ], 400);
        }
        if ($vendor->amount < $request->withdraw_amount) {
            Session::flash('warning', __("You don\'t have enough amount to withdraw") . "!");
            return response()->json(['status' => 'success'], 200);
        }

        //calculation
        $fixed_charge = $method->fixed_charge;
        $percentage = $method->percentage_charge;

        $percentage_balance = (($request->withdraw_amount - $fixed_charge) * $percentage) / 100;
        $total_charge = $percentage_balance + $fixed_charge;
        $receive_balance = $request->withdraw_amount - $total_charge;
        //calculation end
        $save = new Withdraw;
        $save->withdraw_id = uniqid();
        $save->vendor_id = Auth::guard('vendor')->user()->id;
        $save->method_id = $request->withdraw_method;


        $vendor = Vendor::where('id', Auth::guard('vendor')->user()->id)->first();
        $pre_balance = $vendor->amount;
        $vendor->amount = ($vendor->amount - ($request->withdraw_amount));
        $vendor->save();
        $after_balance = $vendor->amount;

        $save->amount = $request->withdraw_amount;
        $save->payable_amount = $receive_balance;
        $save->total_charge = $total_charge;
        $save->additional_reference = $request->additional_reference;
        $save->feilds = json_encode($fields);
        $save->save();
        VendorNotificationService::send(
            $vendor,
            'vendor_withdraw_requested',
            'Withdraw request received',
            'Your withdraw request has been submitted for review.',
            [
                'withdraw_id' => $save->id,
                'method_id' => $save->method_id,
            ]
        );

        //store data to transcation table
        $currencyInfo = $this->getCurrencyInfo();

        Session::flash('success', __('Withdraw Request Send Successfully') . '!');

        return response()->json(['status' => 'success'], 200);
    }
    //bulkDelete
    public function bulkDelete(Request $request)
    {
        $ids = $request->ids;
        foreach ($ids as $id) {
            $withdraw = Withdraw::where('id', $id)->first();
            $withdraw->delete();
        }
        Session::flash('success', __('Delete Withdraw Request Successfully') . '!');

        return response()->json(['status' => 'success'], 200);
    }
    //Delete
    public function Delete(Request $request)
    {
        $delete = Withdraw::where('id', $request->id)->first();
        $delete->delete();
        return redirect()->back()->with('success', __('Withdraw Request Deleted Successfully') . '!');
    }
}
