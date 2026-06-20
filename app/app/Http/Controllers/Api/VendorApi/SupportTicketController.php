<?php

namespace App\Http\Controllers\Api\VendorApi;

use App\Http\Controllers\Controller;
use App\Models\Conversation;
use App\Models\SupportTicket;
use App\Models\SupportTicketStatus;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Mews\Purifier\Facades\Purifier;
use App\Services\VendorNotificationService;

class SupportTicketController extends Controller
{
    private function checkStatus()
    {
        $status = SupportTicketStatus::first();
        return $status && $status->support_ticket_status === 'active';
    }

    // GET /api/vendor/support-tickets
    public function index(Request $request)
    {
        if (!$this->checkStatus()) {
            return response()->json(['error' => __('Support ticket system is not active')], 403);
        }

        $vendor_id = $request->user()->id;

        $tickets = SupportTicket::where('user_id', $vendor_id)
            ->where('user_type', 'vendor')
            ->when($request->filled('status'), fn($q) => $q->where('status', $request->status))
            ->orderByDesc('id')
            ->paginate(10);

        $tickets->getCollection()->transform(function ($ticket) {
            if ($ticket->attachment) {
                $ticket->attachment_url = asset('assets/admin/img/support-ticket/attachment/' . $ticket->attachment);
            }
            return $ticket;
        });

        return response()->json($tickets, 200);
    }

    // POST /api/vendor/support-tickets/store
    public function store(Request $request)
    {
        if (!$this->checkStatus()) {
            return response()->json(['error' => __('Support ticket system is not active')], 403);
        }

        $rules = [
            'email'   => 'required|email',
            'subject' => 'required',
        ];

        if ($request->hasFile('attachment')) {
            $rules['attachment'] = [
                'file',
                'max:20480',
                function ($attribute, $value, $fail) {
                    if ($value->getClientOriginalExtension() !== 'zip') {
                        $fail(__('Only zip files are supported'));
                    }
                },
            ];
        }

        $validator = Validator::make($request->all(), $rules);
        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $in                = $request->only(['email', 'subject', 'description']);
        $in['user_id']     = $request->user()->id;
        $in['user_type']   = 'vendor';
        $in['description'] = Purifier::clean($request->description ?? '', 'youtube');

        if ($request->hasFile('attachment')) {
            $file     = $request->file('attachment');
            $fileName = uniqid() . '.' . $file->getClientOriginalExtension();
            $file->move(public_path('assets/admin/img/support-ticket/attachment/'), $fileName);
            $in['attachment'] = $fileName;
        }

        $ticket = SupportTicket::create($in);
        VendorNotificationService::send(
            $request->user(),
            'vendor_support_ticket_created',
            'Ticket created',
            'Your support ticket has been created successfully.',
            [
                'ticket_id' => $ticket->id,
            ]
        );

        return response()->json([
            'message' => __('Support Ticket Created Successfully') . '!',
            'ticket'  => $ticket,
        ], 201);
    }

    // GET /api/vendor/support-tickets/{id}
    public function show(Request $request, $id)
    {
        if (!$this->checkStatus()) {
            return response()->json(['error' => __('Support ticket system is not active')], 403);
        }

        $ticket = SupportTicket::with('messages')->find($id);

        if (!$ticket) {
            return response()->json(['error' => __('Ticket not found')], 404);
        }

        if ($ticket->user_type !== 'vendor' || $ticket->user_id !== $request->user()->id) {
            return response()->json(['error' => __('Unauthorized')], 403);
        }

        $ticket->messages->transform(function ($msg) {
            if ($msg->file) {
                $msg->file_url = asset('assets/admin/img/support-ticket/' . $msg->file);
            }
            return $msg;
        });

        if ($ticket->attachment) {
            $ticket->attachment_url = asset('assets/admin/img/support-ticket/attachment/' . $ticket->attachment);
        }

        return response()->json($ticket, 200);
    }

    // POST /api/vendor/support-tickets/{id}/reply
    public function reply(Request $request, $id)
    {
        if (!$this->checkStatus()) {
            return response()->json(['error' => __('Support ticket system is not active')], 403);
        }

        $ticket = SupportTicket::find($id);

        if (!$ticket) {
            return response()->json(['error' => __('Ticket not found')], 404);
        }

        if ($ticket->user_type !== 'vendor' || $ticket->user_id !== $request->user()->id) {
            return response()->json(['error' => __('Unauthorized')], 403);
        }

        $rules = ['reply' => 'required'];

        if ($request->hasFile('file')) {
            $rules['file'] = [
                'file',
                'max:20480',
                function ($attribute, $value, $fail) {
                    if ($value->getClientOriginalExtension() !== 'zip') {
                        $fail(__('Only zip files are supported'));
                    }
                },
            ];
        }

        $validator = Validator::make($request->all(), $rules);
        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $input = [
            'reply'             => Purifier::clean($request->reply, 'youtube'),
            'user_id'           => $request->user()->id,
            'type'              => 3,
            'support_ticket_id' => $id,
        ];

        if ($request->hasFile('file')) {
            $file     = $request->file('file');
            $fileName = uniqid() . '.' . $file->getClientOriginalExtension();
            $file->move(public_path('assets/admin/img/support-ticket/'), $fileName);
            $input['file'] = $fileName;
        }

        $conversation = Conversation::create($input);

        SupportTicket::where('id', $id)->update(['last_message' => Carbon::now()]);
        VendorNotificationService::send(
            $request->user(),
            'vendor_support_ticket_replied',
            'Reply sent',
            'Your reply has been added to support ticket #' . $id . '.',
            [
                'ticket_id' => $id,
            ]
        );

        return response()->json([
            'message'      => __('Message Sent Successfully') . '!',
            'conversation' => $conversation,
        ], 201);
    }

    // DELETE /api/vendor/support-tickets/{id}
    public function delete(Request $request, $id)
    {
        $ticket = SupportTicket::find($id);

        if (!$ticket) {
            return response()->json(['error' => __('Ticket not found')], 404);
        }

        if ($ticket->user_type !== 'vendor' || $ticket->user_id !== $request->user()->id) {
            return response()->json(['error' => __('Unauthorized')], 403);
        }

        foreach ($ticket->messages as $msg) {
            @unlink(public_path('assets/admin/img/support-ticket/' . $msg->file));
            $msg->delete();
        }

        @unlink(public_path('assets/admin/img/support-ticket/attachment/' . $ticket->attachment));
        $ticket->delete();

        return response()->json(['message' => __('Support Ticket Deleted Successfully') . '!'], 200);
    }
}
