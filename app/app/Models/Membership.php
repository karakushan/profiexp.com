<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Membership extends Model
{
    use HasFactory;

    protected $fillable = [
        'package_price',
        'discount',
        'coupon_code',
        'price',
        'currency',
        'currency_symbol',
        'payment_method',
        'transaction_id',
        'status',
        'is_trial',
        'trial_days',
        'receipt',
        'transaction_details',
        'settings',
        'package_id',
        'vendor_id',
        'start_date',
        'expire_date',
        'conversation_id',
        'invoice',
        'claim_id',
        'ai_engine',
        'ai_token_limit',
        'ai_image_limit',
        'ai_used_tokens',
        'ai_used_images',
        'ai_token_purchased',
        'ai_image_purchased'
    ];

    public function vendor()
    {
        return $this->belongsTo(Vendor::class, 'vendor_id');
    }

    public function package()
    {
        return $this->belongsTo(Package::class, 'package_id');
    }
}
