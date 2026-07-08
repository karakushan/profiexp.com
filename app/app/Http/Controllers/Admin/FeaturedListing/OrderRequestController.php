<?php

namespace App\Http\Controllers\Admin\FeaturedListing;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

use App\Http\Controllers\FrontEnd\MiscellaneousController;
use App\Models\BasicSettings\Basic;
use Carbon\Carbon;
use Illuminate\Support\Facades\Session;
use App\Models\FeatureOrder;
use App\Models\BasicSettings\MailTemplate;
use App\Models\Language;
use App\Models\Listing\Listing;
use App\Models\Listing\ListingContent;
use App\Models\Vendor;
use App\Models\VendorInfo;
use App\Services\VendorNotificationService;
use Config;
use Exception;
use Illuminate\Mail\Message;
use Illuminate\Support\Facades\Mail;
use Barryvdh\DomPDF\Facade\Pdf;

class OrderRequestController extends Controller
{
    public function index(Request $request)
    {
        $information['langs'] = Language::all();
        $language = Language::query()->where('code', '=', $request->language)->firstOrFail();
        $information['language'] = $language;
        $orderNumber = $paymentStatus = $orderStatus = $title = null;

        $listingIds = [];
        if ($request->filled('title')) {
            $title = $request->title;
            $listing_contents = ListingContent::where('language_id', $language->id)
                ->where('title', 'like', '%' . $title . '%')
                ->get()
                ->pluck('listing_id');
            foreach ($listing_contents as $listing_content) {
                if (!in_array($listing_content, $listingIds)) {
                    array_push($listingIds, $listing_content);
                }
            }
        }

        if ($request->filled('order_no')) {
            $orderNumber = $request['order_no'];
        }
        if ($request->filled('payment_status')) {
            $paymentStatus = $request['payment_status'];
        }
        if ($request->filled('order_status')) {
            $orderStatus = $request['order_status'];
        }

        $orders = FeatureOrder::query()->when($orderNumber, function ($query, $orderNumber) {
            return $query->where('order_number', 'like', '%' . $orderNumber . '%');
        })
            ->when($title, function ($query) use ($listingIds) {
                return $query->whereIn('feature_orders.listing_id', $listingIds);
            })
            ->when($paymentStatus, function ($query, $paymentStatus) {
                return $query->where('payment_status', '=', $paymentStatus);
            })
            ->when($orderStatus, function ($query, $orderStatus) {
                return $query->where('order_status', '=', $orderStatus);
            })
            ->orderByDesc('id')
            ->paginate(10);

        $information['orders'] = $orders;
        return view('admin.featured-listing.index',  $information);
    }
    public function pending(Request $request)
    {
        $information['langs'] = Language::all();
        $language = Language::query()->where('code', '=', $request->language)->firstOrFail();
        $information['language'] = $language;
        $orderNumber = $paymentStatus = $orderStatus = $title = null;

        $listingIds = [];
        if ($request->filled('title')) {
            $title = $request->title;
            $listing_contents = ListingContent::where('language_id', $language->id)
                ->where('title', 'like', '%' . $title . '%')
                ->get()
                ->pluck('listing_id');
            foreach ($listing_contents as $listing_content) {
                if (!in_array($listing_content, $listingIds)) {
                    array_push($listingIds, $listing_content);
                }
            }
        }

        if ($request->filled('order_no')) {
            $orderNumber = $request['order_no'];
        }
        if ($request->filled('payment_status')) {
            $paymentStatus = $request['payment_status'];
        }
        if ($request->filled('order_status')) {
            $orderStatus = $request['order_status'];
        }

        $orders = FeatureOrder::query()->when($orderNumber, function ($query, $orderNumber) {
            return $query->where('order_number', 'like', '%' . $orderNumber . '%');
        })
            ->when($title, function ($query) use ($listingIds) {
                return $query->whereIn('feature_orders.listing_id', $listingIds);
            })
            ->when($paymentStatus, function ($query, $paymentStatus) {
                return $query->where('payment_status', '=', $paymentStatus);
            })
            ->when($orderStatus, function ($query, $orderStatus) {
                return $query->where('order_status', '=', $orderStatus);
            })
            ->where('order_status', 'pending')
            ->orderByDesc('id')
            ->paginate(10);

        $information['orders'] = $orders;
        return view('admin.featured-listing.pending',  $information);
    }
    public function approved(Request $request)
    {
        $information['langs'] = Language::all();
        $language = Language::query()->where('code', '=', $request->language)->firstOrFail();
        $information['language'] = $language;
        $orderNumber = $paymentStatus = $orderStatus = $title = null;

        $listingIds = [];
        if ($request->filled('title')) {
            $title = $request->title;
            $listing_contents = ListingContent::where('language_id', $language->id)
                ->where('title', 'like', '%' . $title . '%')
                ->get()
                ->pluck('listing_id');
            foreach ($listing_contents as $listing_content) {
                if (!in_array($listing_content, $listingIds)) {
                    array_push($listingIds, $listing_content);
                }
            }
        }

        if ($request->filled('order_no')) {
            $orderNumber = $request['order_no'];
        }
        if ($request->filled('payment_status')) {
            $paymentStatus = $request['payment_status'];
        }
        if ($request->filled('order_status')) {
            $orderStatus = $request['order_status'];
        }

        $orders = FeatureOrder::query()->when($orderNumber, function ($query, $orderNumber) {
            return $query->where('order_number', 'like', '%' . $orderNumber . '%');
        })
            ->when($title, function ($query) use ($listingIds) {
                return $query->whereIn('feature_orders.listing_id', $listingIds);
            })
            ->when($paymentStatus, function ($query, $paymentStatus) {
                return $query->where('payment_status', '=', $paymentStatus);
            })
            ->when($orderStatus, function ($query, $orderStatus) {
                return $query->where('order_status', '=', $orderStatus);
            })
            ->where('order_status', 'completed')
            ->orderByDesc('id')
            ->paginate(10);

        $information['orders'] = $orders;
        return view('admin.featured-listing.approve',  $information);
    }
    public function rejected(Request $request)
    {
        $information['langs'] = Language::all();
        $language = Language::query()->where('code', '=', $request->language)->firstOrFail();
        $information['language'] = $language;
        $orderNumber = $paymentStatus = $orderStatus = $title = null;

        $listingIds = [];
        if ($request->filled('title')) {
            $title = $request->title;
            $listing_contents = ListingContent::where('language_id', $language->id)
                ->where('title', 'like', '%' . $title . '%')
                ->get()
                ->pluck('listing_id');
            foreach ($listing_contents as $listing_content) {
                if (!in_array($listing_content, $listingIds)) {
                    array_push($listingIds, $listing_content);
                }
            }
        }

        if ($request->filled('order_no')) {
            $orderNumber = $request['order_no'];
        }
        if ($request->filled('payment_status')) {
            $paymentStatus = $request['payment_status'];
        }
        if ($request->filled('order_status')) {
            $orderStatus = $request['order_status'];
        }

        $orders = FeatureOrder::query()->when($orderNumber, function ($query, $orderNumber) {
            return $query->where('order_number', 'like', '%' . $orderNumber . '%');
        })
            ->when($title, function ($query) use ($listingIds) {
                return $query->whereIn('feature_orders.listing_id', $listingIds);
            })
            ->when($paymentStatus, function ($query, $paymentStatus) {
                return $query->where('payment_status', '=', $paymentStatus);
            })
            ->when($orderStatus, function ($query, $orderStatus) {
                return $query->where('order_status', '=', $orderStatus);
            })
            ->where('order_status', 'rejected')
            ->orderByDesc('id')
            ->paginate(10);

        $information['orders'] = $orders;
        return view('admin.featured-listing.rejected',  $information);
    }

    public function updatePaymentStatus(Request $request, $id)
    {
        $order = FeatureOrder::find($id);
        $misc = new MiscellaneousController();
        $language = $misc->getLanguage();

        $listing = Listing::with(['listing_content' => function ($query) use ($language) {
            return $query->where('language_id', $language->id);
        }])->where('id', $order->listing_id)->first();

        $listing_name = $listing->listing_content[0]->title;
        $slug = $listing->listing_content[0]->slug;
        $url = listing_url($slug, default_front_locale());


        $vendor = VendorInfo::Where('vendor_id', $order->vendor_id)->first();

        $info = Basic::select('google_recaptcha_status')->first();
        if ($info->google_recaptcha_status == 1) {
            $rules['g-recaptcha-response'] = 'required|captcha';
        }

        $be = Basic::select('smtp_status', 'smtp_host', 'smtp_port', 'encryption', 'smtp_username', 'smtp_password', 'from_mail', 'from_name', 'to_mail', 'website_title')->firstOrFail();



        if ($request['payment_status'] == 'pending') {

            $order->update([
                'payment_status' => 'pending'
            ]);
            VendorNotificationService::send(
                Vendor::find($order->vendor_id),
                'vendor_feature_payment_status_updated',
                'Feature payment updated',
                'Payment status for your featured listing request is now pending.',
                [
                    'feature_order_id' => $order->id,
                    'listing_id' => $order->listing_id,
                ]
            );
        } else if ($request['payment_status'] == 'completed') {

            $order->update([
                'payment_status' => 'completed'
            ]);
            VendorNotificationService::send(
                Vendor::find($order->vendor_id),
                'vendor_feature_payment_status_updated',
                'Feature payment updated',
                'Payment status for your featured listing request is now completed.',
                [
                    'feature_order_id' => $order->id,
                    'listing_id' => $order->listing_id,
                ]
            );


            // generate an invoice in pdf format 
            $invoice = $this->generateInvoice($order);

            // then, update the invoice field info in database 
            $order->update(['invoice' => $invoice]);

            $mail_template = MailTemplate::where('mail_type', 'payment_accepted_for_featured_offline_gateway')->first();


            if ($be->smtp_status == 1) {
                $subject = $mail_template->mail_subject;

                $body = $mail_template->mail_body;
                $body = preg_replace("/{username}/", $vendor->name, $body);
                $body = preg_replace("/{payment_via}/", $order->payment_method, $body);
                $body = preg_replace("/{listing_name}/", "<a href=" . $url . ">$listing_name</a>", $body);
                $body = preg_replace("/{package_price}/", $order->total, $body);
                $body = preg_replace("/{website_title}/", $be->website_title, $body);

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
                    $data = [
                        'to' => $order->vendor_mail,
                        'subject' => $subject,
                        'body' => $body,
                        'invoice' => public_path('assets/file/invoices/listing-feature/' . $invoice)
                    ];
                    if ($be->smtp_status == 1) {
                        Mail::send([], [], function (Message $message) use ($data, $be) {
                            $fromMail = $be->from_mail;
                            $fromName = $be->from_name;
                            $message->to($data['to'])
                                ->subject($data['subject'])
                                ->from($fromMail, $fromName)
                                ->html($data['body'], 'text/html');
                            if (array_key_exists('invoice', $data) && file_exists($data['invoice'])) {
                                $message->attach($data['invoice'], [
                                    'as' => 'Invoice.pdf',
                                    'mime' => 'application/pdf',
                                ]);
                            }
                        });
                    }

                    Session::flash('success', __('Message sent successfully') . '!');
                    return back();
                } catch (Exception $e) {
                    Session::flash('error', $e);
                    return back();
                }
            }
        } else {

            $order->update([
                'payment_status' => 'rejected',
                'order_status' => 'rejected'
            ]);
            VendorNotificationService::send(
                Vendor::find($order->vendor_id),
                'vendor_feature_payment_status_updated',
                'Feature payment updated',
                'Payment status for your featured listing request is now rejected.',
                [
                    'feature_order_id' => $order->id,
                    'listing_id' => $order->listing_id,
                ]
            );
            $mail_template = MailTemplate::where('mail_type', 'payment_rejected_for_buy_feature_offline_gateway')->first();

            if ($be->smtp_status == 1) {
                $subject = $mail_template->mail_subject;

                $body = $mail_template->mail_body;

                $body = preg_replace("/{payment_via}/", $order->payment_method, $body);
                $body = preg_replace("/{listing_name}/", "<a href=" . $url . ">$listing_name</a>", $body);
                $body = preg_replace("/{package_price}/", $order->total, $body);
                $body = preg_replace("/{username}/", $vendor->name, $body);
                $body = preg_replace("/{website_title}/", $be->website_title, $body);

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
                    $data = [
                        'to' => $order->vendor_mail,
                        'subject' => $subject,
                        'body' => $body,
                    ];
                    if ($be->smtp_status == 1) {
                        Mail::send([], [], function (Message $message) use ($data, $be) {
                            $fromMail = $be->from_mail;
                            $fromName = $be->from_name;
                            $message->to($data['to'])
                                ->subject($data['subject'])
                                ->from($fromMail, $fromName)
                                ->html($data['body'], 'text/html');
                        });
                    }

                    Session::flash('success', __('Message sent successfully') . '!');
                    return back();
                } catch (Exception $e) {
                    Session::flash('error', $e);
                    return back();
                }
            }
        }
        return redirect()->back();
    }
    public function generateInvoice($order)
    {
        $fileName = $order->id . '.pdf';
        $directory = public_path('assets/file/invoices/listing-feature/');
        @mkdir($directory, 0775, true);

        if (!file_exists($directory)) {
            @mkdir($directory, 0775, true);
        }

        $fileLocated = $directory . $fileName;

        $position = $order->currency_text_position;
        $currency = $order->currency_text;

        Pdf::loadView('pdf.listing-feature', compact('order', 'position', 'currency'))->save($fileLocated);

        return $fileName;
    }

    public function updateOrderStatus(Request $request, $id)
    {
        $order = FeatureOrder::find($id);

        $vendor = VendorInfo::Where('vendor_id', $order->vendor_id)->first();

        $info = Basic::select('google_recaptcha_status')->first();
        if ($info->google_recaptcha_status == 1) {
            $rules['g-recaptcha-response'] = 'required|captcha';
        }

        $be = Basic::select('smtp_status', 'smtp_host', 'smtp_port', 'encryption', 'smtp_username', 'smtp_password', 'from_mail', 'from_name', 'to_mail', 'website_title')->firstOrFail();

        $misc = new MiscellaneousController();
        $language = $misc->getLanguage();

        $listing = Listing::with(['listing_content' => function ($query) use ($language) {
            return $query->where('language_id', $language->id);
        }])->where('id', $order->listing_id)->first();

        $listing_name = $listing->listing_content[0]->title;
        $slug = $listing->listing_content[0]->slug;
        $url = listing_url($slug, default_front_locale());

        if ($request['order_status'] == 'pending') {

            $order->update([
                'order_status' => 'pending'
            ]);
            VendorNotificationService::send(
                Vendor::find($order->vendor_id),
                'vendor_feature_status_updated',
                'Feature request updated',
                'Your featured listing request is now pending.',
                [
                    'feature_order_id' => $order->id,
                    'listing_id' => $order->listing_id,
                ]
            );
        } else if ($request['order_status'] == 'completed') {

            $days = $order->days;

            $startDates = Carbon::now()->startOfDay();
            $endDates = $startDates->copy()->addDays($days);

            $order->update([

                'order_status' => 'completed',
                'start_date' => $startDates,
                'end_date' => $endDates

            ]);
            VendorNotificationService::send(
                Vendor::find($order->vendor_id),
                'vendor_feature_status_updated',
                'Feature request updated',
                'Your featured listing request has been completed and activated.',
                [
                    'feature_order_id' => $order->id,
                    'listing_id' => $order->listing_id,
                ]
            );
            $startDate = $startDates->format('j F, Y');
            $endDate = $endDates->format('j F, Y');
            $mail_template = MailTemplate::where('mail_type', 'listing_feature_active')->first();

            if ($be->smtp_status == 1) {
                $subject = $mail_template->mail_subject;

                $body = $mail_template->mail_body;
                $body = preg_replace("/{username}/", $vendor->name, $body);
                $body = preg_replace("/{listing_name}/", "<a href=" . $url . ">$listing_name</a>", $body);
                $body = preg_replace("/{days}/", $days, $body);

                $body = preg_replace("/{activation_date}/", $startDate, $body);

                $body = preg_replace("/{end_date}/", $endDate, $body);
                $body = preg_replace("/{website_title}/", $be->website_title, $body);

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
                    $data = [
                        'to' => $order->vendor_mail,
                        'subject' => $subject,
                        'body' => $body,
                    ];
                    if ($be->smtp_status == 1) {
                        Mail::send([], [], function (Message $message) use ($data, $be) {
                            $fromMail = $be->from_mail;
                            $fromName = $be->from_name;
                            $message->to($data['to'])
                                ->subject($data['subject'])
                                ->from($fromMail, $fromName)
                                ->html($data['body'], 'text/html');
                        });
                    }

                    Session::flash('success', __('Message sent successfully') . '!');
                    return back();
                } catch (Exception $e) {
                    Session::flash('error', $e);
                    return back();
                }
            }
        } else {

            $order->update([
                'order_status' => 'rejected'
            ]);
            VendorNotificationService::send(
                Vendor::find($order->vendor_id),
                'vendor_feature_status_updated',
                'Feature request updated',
                'Your featured listing request has been rejected.',
                [
                    'feature_order_id' => $order->id,
                    'listing_id' => $order->listing_id,
                ]
            );

            $mail_template = MailTemplate::where('mail_type', 'listing_feature_reject')->first();

            if ($be->smtp_status == 1) {
                $subject = $mail_template->mail_subject;

                $body = $mail_template->mail_body;
                $body = preg_replace("/{username}/", $vendor->name, $body);
                $body = preg_replace("/{listing_name}/", "<a href=" . $url . ">$listing_name</a>", $body);
                $body = preg_replace("/{website_title}/", $be->website_title, $body);

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
                    $data = [
                        'to' => $order->vendor_mail,
                        'subject' => $subject,
                        'body' => $body,
                    ];
                    if ($be->smtp_status == 1) {
                        Mail::send([], [], function (Message $message) use ($data, $be) {
                            $fromMail = $be->from_mail;
                            $fromName = $be->from_name;
                            $message->to($data['to'])
                                ->subject($data['subject'])
                                ->from($fromMail, $fromName)
                                ->html($data['body'], 'text/html');
                        });
                    }

                    Session::flash('success', __('Message sent successfully') . '!');
                    return back();
                } catch (Exception $e) {
                    Session::flash('error', $e);
                    return back();
                }
            }
        }

        return redirect()->back();
    }



    public function destroy($id)
    {
        $order = FeatureOrder::find($id);

        // delete the attachment
        @unlink(public_path('assets/file/attachments/feature-activation/') . $order->attachment);
        @unlink(public_path('assets/file/invoices/listing-feature/') . $order->invoice);

        $order->delete();

        return redirect()->back()->with('success', __('Deleted successfully') . '!');
    }

    public function bulkDestroy(Request $request)
    {
        $ids = $request->ids;

        foreach ($ids as $id) {
            $order = FeatureOrder::find($id);

            // delete the attachment
            @unlink(public_path('assets/file/attachments/feature-activation/') . $order->attachment);
            @unlink(public_path('assets/file/invoices/listing-feature/') . $order->invoice);

            $order->delete();
        }

        Session::flash('success', __('Selectet item deleted successfully') . '!');

        return response()->json(['status' => 'success'], 200);
    }
}
