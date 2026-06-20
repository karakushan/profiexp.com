<?php

namespace App\Http\Controllers\Api\VendorApi;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;

class MAilSetController extends Controller
{
    // GET /api/vendor/mail-setting
    public function mailToAdmin(Request $request)
    {
        $data = DB::table('vendors')->where('id', $request->user()->id)->select('to_mail')->first();

        return response()->json([
            'status' => true,
            'data'   => [
                'recived_email' => $data->to_mail ?? '',
            ],
        ], 200);
    }

    // POST /api/vendor/mail-setting/update
    public function updateMailToAdmin(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'to_mail' => 'required|email',
        ], [
            'to_mail.required' => __('The mail address field is required.'),
            'to_mail.email'    => __('The mail address must be a valid email.'),
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        DB::table('vendors')->where('id', $request->user()->id)->update([
            'to_mail' => $request->to_mail,
        ]);

        return response()->json(['status' => true, 'message' => __('Mail info updated successfully') . '!'], 200);
    }
}
