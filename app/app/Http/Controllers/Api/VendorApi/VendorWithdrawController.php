<?php

namespace App\Http\Controllers\Api\VendorApi;

use App\Http\Controllers\Controller;
use App\Models\Vendor;
use App\Models\Withdraw;
use App\Models\WithdrawMethodInput;
use App\Models\WithdrawPaymentMethod;
use App\Services\VendorNotificationService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class VendorWithdrawController extends Controller
{
    // GET /api/vendor/withdraw
    public function index(Request $request)
    {
        $vendor        = $request->user();
        $currencyInfo  = $this->getCurrencyInfo();
        $symbol         = (string) ($currencyInfo->base_currency_symbol ?? '');
        $symbolPosition = (string) ($currencyInfo->base_currency_symbol_position ?? 'left');
        $balance       = number_format((float) $vendor->amount, 2);
        $withdrawals = Withdraw::with('method')
            ->where('vendor_id', $vendor->id)
            ->orderByDesc('id')
            ->paginate(10);

        return response()->json([
            'success' => true,
            'balance' => $balance,
            'formatted_balance' => $this->formatCurrencyValue($balance, $symbol, $symbolPosition),
            'currency' => $this->currencyPayload($currencyInfo),
            'data' => $withdrawals,
        ], 200);
    }

    // GET /api/vendor/withdraw/methods — list active withdraw methods
    public function methods(Request $request)
    {
        $methods = WithdrawPaymentMethod::where('status', 1)->get();
        $vendor  = $request->user();

        $currencyInfo  = $this->getCurrencyInfo();
        $symbol         = (string) ($currencyInfo->base_currency_symbol ?? '');
        $symbolPosition = (string) ($currencyInfo->base_currency_symbol_position ?? 'left');
        $balance       = number_format((float) $vendor->amount, 2);

        return response()->json([
            'success' => true,
            'data'    => [
                'methods'           => $methods,
                'balance'           => $balance,
                'formatted_balance' => $this->formatCurrencyValue($balance, $symbol, $symbolPosition),
                'currency'          => $this->currencyPayload($currencyInfo),
            ],
        ], 200);
    }

    // GET /api/vendor/withdraw/inputs/{methodId} — get dynamic form inputs for a method
    public function get_inputs($id)
    {
        $inputs = WithdrawMethodInput::with('options')
            ->where('withdraw_payment_method_id', $id)
            ->orderBy('order_number', 'asc')
            ->get();

        return response()->json(['success' => true, 'data' => $inputs], 200);
    }

    // GET /api/vendor/withdraw/calculate?method={id}&amount={amount}
    public function balance_calculation(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'method' => 'required|exists:withdraw_payment_methods,id',
            'amount' => 'required|numeric|min:0',
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $method = WithdrawPaymentMethod::find($request->method);
        $amount = (float) $request->amount;

        $fixed_charge      = $method->fixed_charge;
        $percentage        = $method->percentage_charge;
        $percentage_charge = (($amount - $fixed_charge) * $percentage) / 100;
        $total_charge      = $percentage_charge + $fixed_charge;
        $receive_balance   = $amount - $total_charge;
        $user_balance      = $request->user()->amount - $amount;

        return response()->json([
            'total_charge'    => round($total_charge, 2),
            'receive_balance' => round($receive_balance, 2),
            'user_balance'    => round($user_balance, 2),
        ], 200);
    }

    // POST /api/vendor/withdraw/request
    public function send_request(Request $request)
    {
        $vendor = Vendor::find($request->user()->id);

        $validator = Validator::make($request->all(), [
            'withdraw_method' => 'required|exists:withdraw_payment_methods,id',
            'withdraw_amount' => 'required|numeric|min:0',
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $method = WithdrawPaymentMethod::find($request->withdraw_method);
        $amount = (float) $request->withdraw_amount;

        if ($amount < $method->min_limit) {
            return response()->json([
                'errors' => ['withdraw_amount' => [__('Minimum withdraw limit is') . ' ' . $method->min_limit]]
            ], 422);
        }

        if ($amount > $method->max_limit) {
            return response()->json([
                'errors' => ['withdraw_amount' => [__('Maximum withdraw limit is') . ' ' . $method->max_limit]]
            ], 422);
        }

        if ($vendor->amount < $amount) {
            return response()->json([
                'error' => __("You don't have enough balance to withdraw") . '!'
            ], 422);
        }

        // Build dynamic fields
        $inputs  = WithdrawMethodInput::where('withdraw_payment_method_id', $request->withdraw_method)
            ->orderBy('order_number', 'asc')
            ->get();

        $rules  = [];
        $fields = [];
        foreach ($inputs as $input) {
            if ($input->required == 1) {
                $rules[$input->name] = 'required';
            }
            if ($request->has($input->name)) {
                $fields[$input->name] = $request->input($input->name);
            }
        }

        if (!empty($rules)) {
            $inputValidator = Validator::make($request->all(), $rules);
            if ($inputValidator->fails()) {
                return response()->json(['errors' => $inputValidator->errors()], 422);
            }
        }

        // Charge calculation
        $fixed_charge      = $method->fixed_charge;
        $percentage        = $method->percentage_charge;
        $percentage_charge = (($amount - $fixed_charge) * $percentage) / 100;
        $total_charge      = $percentage_charge + $fixed_charge;
        $receive_balance   = $amount - $total_charge;

        // Deduct balance
        $vendor->amount -= $amount;
        $vendor->save();

        $withdraw = Withdraw::create([
            'withdraw_id'          => uniqid(),
            'vendor_id'            => $vendor->id,
            'method_id'            => $request->withdraw_method,
            'amount'               => $amount,
            'payable_amount'       => round($receive_balance, 2),
            'total_charge'         => round($total_charge, 2),
            'additional_reference' => $request->additional_reference,
            'feilds'               => json_encode($fields),
        ]);
        VendorNotificationService::send(
            $vendor,
            'vendor_withdraw_requested',
            'Withdraw request received',
            'Your withdraw request has been submitted for review.',
            [
                'withdraw_id' => $withdraw->id,
                'method_id' => $withdraw->method_id,
            ]
        );

        return response()->json([
            'success' => true,
            'message' => __('Withdraw Request Sent Successfully') . '!',
            'data'    => [
                'withdraw'          => $withdraw->load('method'),
                'remaining_balance' => round($vendor->amount, 2),
            ],
        ], 201);
    }

    // DELETE /api/vendor/withdraw/{id}
    public function delete(Request $request, $id)
    {
        $withdraw = Withdraw::where('id', $id)
            ->where('vendor_id', $request->user()->id)
            ->first();

        if (!$withdraw) {
            return response()->json(['error' => __('Withdraw request not found')], 404);
        }

        $withdraw->delete();

        return response()->json(['message' => __('Withdraw Request Deleted Successfully') . '!'], 200);
    }

    // POST /api/vendor/withdraw/bulk-delete
    public function bulkDelete(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'ids'   => 'required|array',
            'ids.*' => 'integer',
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        Withdraw::whereIn('id', $request->ids)
            ->where('vendor_id', $request->user()->id)
            ->delete();

        return response()->json(['message' => __('Withdraw Requests Deleted Successfully') . '!'], 200);
    }

    private function formatCurrencyValue(string $amount, string $symbol, string $symbolPosition): string
    {
        $cleanSymbol = trim($symbol);
        if ($cleanSymbol === '') {
            return $amount;
        }

        if (strtolower(trim($symbolPosition)) === 'right') {
            return $amount . ' ' . $cleanSymbol;
        }

        return $cleanSymbol . $amount;
    }

    private function currencyPayload($currencyInfo): array
    {
        return [
            'base_currency_text' => (string) ($currencyInfo->base_currency_text ?? ''),
            'base_currency_symbol' => (string) ($currencyInfo->base_currency_symbol ?? ''),
            'base_currency_symbol_position' => (string) ($currencyInfo->base_currency_symbol_position ?? 'left'),
        ];
    }
}
