<?php

namespace App\Models;

use App\Models\BasicSettings\CookieAlert;
use App\Models\BasicSettings\PageHeading;
use App\Models\BasicSettings\SEO;
use App\Models\CustomPage\PageContent;
use App\Models\FAQ;
use App\Models\Footer\FooterContent;
use App\Models\Footer\QuickLink;
use App\Models\HomePage\Banner;
use App\Models\HomePage\BlogSection;
use App\Models\HomePage\CallToActionSection;
use App\Models\HomePage\CategorySection;
use App\Models\HomePage\CounterInformation;
use App\Models\HomePage\Hero\Slider;
use App\Models\HomePage\Methodology\WorkProcess;
use App\Models\HomePage\Methodology\WorkProcessSection;
use App\Models\HomePage\Prominence\Feature;
use App\Models\HomePage\Testimony\Testimonial;
use App\Models\HomePage\Testimony\TestimonialSection;
use App\Models\Journal\BlogCategory;
use App\Models\Journal\BlogCategoryContent;
use App\Models\Journal\BlogInformation;
use App\Models\MenuBuilder;
use App\Models\Popup;
use App\Models\Prominence\FeatureSection;
use App\Models\Shop\ProductCategory;
use App\Models\Shop\ProductContent;
use App\Models\Shop\ShippingCharge;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\ListingCategory;
use App\Models\Aminite;
use App\Models\HomePage\HeroSection;
use App\Models\HomePage\LocationSection;
use App\Models\HomePage\VideoSection;
use App\Models\Listing\ListingContent;
use App\Models\Listing\ListingFaq;
use App\Models\Location\City;
use App\Models\Location\CityContent;
use App\Models\Location\Country;
use App\Models\Location\CountryContent;
use App\Models\Location\State;
use App\Models\Location\StateContent;

class Language extends Model
{
  use HasFactory;

  /**
   * The attributes that are mass assignable.
   *
   * @var array
   */
  protected $fillable = ['name', 'code', 'direction', 'is_default'];

  public function listingContent()
  {
    return $this->hasOne(ListingContent::class, 'language_id', 'id');
  }

  public function faq()
  {
    return $this->hasMany(FAQ::class);
  }

  public function customPageInfo()
  {
    return $this->hasMany(PageContent::class);
  }

  public function footerContent()
  {
    return $this->hasOne(FooterContent::class);
  }

  public function footerQuickLink()
  {
    return $this->hasMany(QuickLink::class);
  }

  public function announcementPopup()
  {
    return $this->hasMany(Popup::class);
  }

  public function blogCategory()
  {
    return $this->hasManyThrough(BlogCategory::class, BlogCategoryContent::class, 'language_id', 'id', 'id', 'blog_category_id');
  }

  public function blogInformation()
  {
    return $this->hasMany(BlogInformation::class);
  }

  public function menuInfo()
  {
    return $this->hasOne(MenuBuilder::class, 'language_id', 'id');
  }


  public function workProcessSection()
  {
    return $this->hasOne(WorkProcessSection::class, 'language_id', 'id');
  }

  public function workProcess()
  {
    return $this->hasMany(WorkProcess::class, 'language_id', 'id');
  }

  public function featureSection()
  {
    return $this->hasOne(FeatureSection::class, 'language_id', 'id');
  }

  public function counterInfo()
  {
    return $this->hasMany(CounterInformation::class, 'language_id', 'id');
  }
    public function countryInfo()
  {
    return $this->hasMany(CountryContent::class, 'language_id', 'id');
  }
  public function stateInfo()
  {
    return $this->hasMany(StateContent::class, 'language_id', 'id');
  }
  public function cityInfo()
  {
    return $this->hasMany(CityContent::class, 'language_id', 'id');
  }
  public function counterSection()
  {
    return $this->hasMany(CounterSection::class, 'language_id', 'id');
  }

  public function testimonialSection()
  {
    return $this->hasOne(TestimonialSection::class, 'language_id', 'id');
  }

  public function testimonial()
  {
    return $this->hasMany(Testimonial::class, 'language_id', 'id');
  }

  public function callToActionSection()
  {
    return $this->hasOne(CallToActionSection::class, 'language_id', 'id');
  }
  public function videoSection()
  {
    return $this->hasOne(VideoSection::class, 'language_id', 'id');
  }

  public function blogSection()
  {
    return $this->hasOne(BlogSection::class, 'language_id', 'id');
  }
  public function locationSection()
  {
    return $this->hasOne(LocationSection::class, 'language_id', 'id');
  }

  public function shippingCharge()
  {
    return $this->hasMany(ShippingCharge::class);
  }

  public function productCategory()
  {
    return $this->hasMany(ProductCategory::class);
  }
  public function listingFAq()
  {
    return $this->hasMany(ListingFaq::class);
  }

  public function productContent()
  {
    return $this->hasMany(ProductContent::class);
  }
  public function heroSection()
  {
    return $this->hasOne(HeroSection::class, 'language_id', 'id');
  }


  //new relation are goes here

  public function listingCategory()
  {
    return $this->hasMany(ListingCategoryContent::class);
  }

  public function CategorySection()
  {
    return $this->hasMany(CategorySection::class);
  }

  public function vendorInfo()
  {
    return $this->hasOne(VendorInfo::class);
  }

  public function sliderInfo()
  {
    return $this->hasMany(Slider::class, 'language_id', 'id');
  }

  public function banner()
  {
    return $this->hasOne(Banner::class);
  }
  public function pageName()
  {
    return $this->hasOne(PageHeading::class);
  }

  public function seoInfo()
  {
    return $this->hasOne(SEO::class);
  }
  public function cookieAlertInfo()
  {
    return $this->hasOne(CookieAlert::class);
  }

  public function form()
  {
    return $this->hasMany(Form::class, 'language_id', 'id');
  }
}
