<?php

namespace App\Models;

use App\Models\Listing\Listing;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class FeatureOrder extends Model
{
    use HasFactory;
    protected $fillable = [
        'listing_id',
        'vendor_id',
        'order_number',
        'total',
        'payment_method',
        'gateway_type',
        'payment_status',
        'order_status',
        'attachment',
        'invoice',
        'days',
        'start_date',
        'end_date'
    ];
    public function listing()
    {
        return $this->belongsTo(Listing::class, 'listing_id', 'id');
    }
    public function vendor()
    {
        return $this->belongsTo(Vendor::class, 'vendor_id', 'id');
    }
}
