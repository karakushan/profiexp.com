<?php

namespace App\Models\Listing;

use App\Models\Shop\Product;
use App\Models\Vendor;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ProductMessage extends Model
{
    use HasFactory;
    protected $fillable = [
        'product_id',
        'vendor_id',
        'name',
        'email',
        'message',
        'information',
    ];
    public function vendor()
    {
        return $this->belongsTo(Vendor::class);
    }
    public function product()
    {
        return $this->belongsTo(Product::class, 'product_id');
    }
}
