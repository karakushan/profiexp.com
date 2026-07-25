<?php

namespace App\Models\Shop;

use App\Models\Shop\Product;
use App\Models\User;
use App\Models\Language;
use App\Models\ReviewTranslation;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ProductReview extends Model
{
  public const TYPE = 'product';

  use HasFactory;

  /**
   * The attributes that are mass assignable.
   *
   * @var array
   */
  protected $fillable = ['user_id', 'product_id', 'comment', 'rating', 'status', 'language_id'];

  public function userInfo()
  {
    return $this->belongsTo(User::class, 'user_id', 'id');
  }

  public function productInfo()
  {
    return $this->belongsTo(Product::class);
  }

  public function language()
  {
    return $this->belongsTo(Language::class);
  }

  public function translations()
  {
    return $this->hasMany(ReviewTranslation::class, 'review_id')->where('review_type', self::TYPE);
  }
}
