<?php

namespace App\Http\Controllers\FrontEnd;

use App\Http\Controllers\Controller;
use App\Models\Admin;
use App\Models\BasicSettings\Basic;
use App\Models\HomePage\Section;
use App\Models\Listing\Listing;
use App\Models\ListingCategory;
use App\Models\Vendor;
use App\Models\VendorInfo;
use Carbon\Carbon;
use Config;
use Illuminate\Http\Request;
use Illuminate\Mail\Message;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Session;
use Validator;

class VendorController extends Controller
{
    //index
    public function index(Request $request)
    {
        $misc = new MiscellaneousController();

        $language = $misc->getLanguage();
        $information['language'] = $language;

        $information['pageHeading'] = $misc->getPageHeading($language);

        $information['seoInfo'] = $language->seoInfo()->select('meta_keywords_vendor_page', 'meta_description_vendor_page')->first();
        $name = $location = null;
        $vendorIds = [];
        $vendorIds = [];
        if ($request->filled('name')) {
            $name = $request->name;
            $u_infos = Vendor::where('vendors.username', 'like', '%' . $name . '%')->get();
            $v_infos = VendorInfo::where([['vendor_infos.name', 'like', '%' . $name . '%'], ['language_id', $language->id]])->get();

            foreach ($u_infos as $info) {
                if (!in_array($info->id, $vendorIds)) {
                    array_push($vendorIds, $info->id);
                }
            }
            foreach ($v_infos as $v_info) {
                if (!in_array($v_info->vendor_id, $vendorIds)) {
                    array_push($vendorIds, $v_info->vendor_id);
                }
            }
        }

        if ($request->filled('location')) {
            $location = $request->location;
        }

        if ($request->filled('location')) {
            $vendor_contents = VendorInfo::where('country', 'like', '%' . $location . '%')
                ->orWhere('city', 'like', '%' . $location . '%')
                ->orWhere('state', 'like', '%' . $location . '%')
                ->orWhere('zip_code', 'like', '%' . $location . '%')
                ->orWhere('address', 'like', '%' . $location . '%')
                ->get();
            foreach ($vendor_contents as $vendor_content) {
                if (!in_array($vendor_content->vendor_id, $vendorIds)) {
                    array_push($vendorIds, $vendor_content->vendor_id);
                }
            }
        }

        $information['bgImg'] = $misc->getBreadcrumb();
        $information['admin'] = Admin::when($name, function ($query) use ($name) {
            return $query->where('admins.username', 'like', '%' . $name . '%');
        })
            ->when($location, function ($query) use ($location) {
                return $query->where('admins.address', 'like', '%' . $location . '%');
            })
            ->Where('admins.id', 1)
            ->first();

        $information['vendors'] = Vendor::join('memberships', 'memberships.vendor_id', 'vendors.id')
            ->where([
                ['memberships.status', 1],
                ['memberships.start_date', '<=', Carbon::now()->format('Y-m-d')],
                ['memberships.expire_date', '>=', Carbon::now()->format('Y-m-d')],
            ])
            ->where('vendors.status', 1)
            ->when($name, function ($query) use ($vendorIds) {
                return $query->whereIn('vendors.id', $vendorIds);
            })
            ->when($location, function ($query) use ($vendorIds) {
                return $query->whereIn('vendors.id', $vendorIds);
            })
            ->where('vendors.id', '!=', 0)
            ->select('vendors.*', 'vendors.id as vendorId', 'memberships.*')
            ->paginate(10);

        return view('frontend.vendor.index', $information);
    }
    //details 
    public function details(Request $request)
    {

        $misc = new MiscellaneousController();

        $language = $misc->getLanguage();
        $information['language'] = $language;

        $information['bgImg'] = $misc->getBreadcrumb();

        $information['pageHeading'] = $misc->getPageHeading($language);

        if ($request->username == "admin") {
            $vendor = Admin::first();
            $vendor_id = 0;
        } else {
            $vendor = Vendor::join('memberships', 'memberships.vendor_id', 'vendors.id')
                ->where([
                    ['memberships.status', 1],
                    ['memberships.start_date', '<=', Carbon::now()->format('Y-m-d')],
                    ['memberships.expire_date', '>=', Carbon::now()->format('Y-m-d')],
                ])
                ->where('vendors.username', $request->username)
                ->where('vendors.status', 1)
                ->select('vendors.*')
                ->firstOrFail();
            $vendorInfo = VendorInfo::where([['vendor_id', $vendor->id], ['language_id', $language->id]])->first();
            $information['vendorInfo'] = $vendorInfo;
            $vendor_id = $vendor->id;
        }

        $information['vendor'] = $vendor;
        $information['vendor_id'] = $vendor_id;

        $information['categories'] = ListingCategory::where([['language_id', $language->id], ['status', 1]])->get();

        $information['listings'] = Listing::where([['listings.vendor_id', $vendor_id], ['listings.status', '=', '1'], ['listings.visibility', '=', '1']])
            ->orderBy('id', 'desc')
            ->get();

        $secInfo = Section::query()->select('subscribe_section_status')->first();
        $information['secInfo'] = $secInfo;
        $information['currencyInfo'] = $this->getCurrencyInfo();
        $information['info'] = Basic::select('google_recaptcha_status')->first();
        return view('frontend.vendor.details', $information);
    }

    //contact
    public function contact(Request $request)
    {
        $rules = [
            'name' => 'required',
            'email' => 'required|email:rfc,dns',
            'subject' => 'required',
            'message' => 'required'
        ];


        $info = Basic::select('google_recaptcha_status')->first();
        if ($info->google_recaptcha_status == 1) {
            $rules['g-recaptcha-response'] = 'required|captcha';
        }
        $messageArray = [];

        if ($info->google_recaptcha_status == 1) {
            $messageArray['g-recaptcha-response.required'] = 'Please verify that you are not a robot.';
            $messageArray['g-recaptcha-response.captcha'] = 'Captcha error! try again later or contact site admin.';
        }

        $validator = Validator::make($request->all(), $rules, $messageArray);
        if ($validator->fails()) {
            return response()->json(['errors' => $validator->getMessageBag()->toArray()], 400);
        }


        $be = Basic::select('smtp_status', 'smtp_host', 'smtp_port', 'encryption', 'smtp_username', 'smtp_password', 'from_mail', 'from_name')->firstOrFail();

        $c_message = nl2br($request->message);
        $msg = "<h4>Name : $request->name</h4>
            <h4>Email : $request->email</h4>
            <p>Message : </p> 
            <p>$c_message</p>
            ";

        $data = [
            'to' => $request->vendor_email,
            'subject' => $request->subject,
            'message' => $msg,
        ];

        if ($be->smtp_status == 1) {
            try {
                $smtp = [
                    'transport' => 'smtp',
                    'host' => $be->smtp_host,
                    'port' => $be->smtp_port,
                    'encryption' => $be->encryption,
                    'username' => $be->smtp_username,
                    'password' => $be->smtp_password,
                    'timeout' => null,
                    'auth_mode' => null,
                ];
                Config::set('mail.mailers.smtp', $smtp);
            } catch (\Exception $e) {
                Session::flash('error', $e->getMessage());
                return back();
            }
        }
        try {
            if ($be->smtp_status == 1) {
                Mail::send([], [], function (Message $message) use ($data, $be) {
                    $fromMail = $be->from_mail;
                    $fromName = $be->from_name;
                    $message->to($data['to'])
                        ->subject($data['subject'])
                        ->from($fromMail, $fromName)
                        ->html($data['message'], 'text/html');
                });
            }
            Session::flash('success', __('Message sent successfully') . '!');
            return response()->json(['message' => 'Message sent successfully'], 200);
        } catch (Exception $e) {
            Session::flash('error', 'Something went wrong.');
            return response()->json(['message' => 'Something went wrong.'], 400);
        }
    }
}
