<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('page_headings', function (Blueprint $table) {
            $table->dropColumn('home_page_title');
        });

        Schema::table('seos', function (Blueprint $table) {
            $table->string('meta_title_home')->nullable()->after('id');
            $table->string('meta_title_listings')->nullable()->after('meta_description_home');
            $table->string('meta_title_pricing')->nullable()->after('meta_description_listings');
            $table->string('meta_title_products')->nullable()->after('meta_description_pricing');
            $table->string('meta_title_blog')->nullable()->after('meta_description_products');
            $table->string('meta_title_faq')->nullable()->after('meta_description_blog');
            $table->string('meta_title_contact')->nullable()->after('meta_description_faq');
            $table->string('meta_title_login')->nullable()->after('meta_description_contact');
            $table->string('meta_title_signup')->nullable()->after('meta_description_login');
            $table->string('meta_title_forget_password')->nullable()->after('meta_description_signup');
            $table->string('meta_title_vendor_signup')->nullable()->after('meta_description_forget_password');
            $table->string('meta_title_vendor_login')->nullable()->after('meta_descriptions_vendor_forget_password');
            $table->string('meta_title_vendor_forget_password')->nullable()->after('meta_descriptions_vendor_forget_password');
            $table->string('meta_title_vendor_page')->nullable()->after('meta_description_vendor_forget_password');
            $table->string('meta_title_about_page')->nullable()->after('meta_description_vendor_page');
        });
    }

    public function down(): void
    {
        Schema::table('page_headings', function (Blueprint $table) {
            $table->string('home_page_title')->nullable()->after('language_id');
        });

        Schema::table('seos', function (Blueprint $table) {
            $table->dropColumn([
                'meta_title_home',
                'meta_title_listings',
                'meta_title_pricing',
                'meta_title_products',
                'meta_title_blog',
                'meta_title_faq',
                'meta_title_contact',
                'meta_title_login',
                'meta_title_signup',
                'meta_title_forget_password',
                'meta_title_vendor_signup',
                'meta_title_vendor_login',
                'meta_title_vendor_forget_password',
                'meta_title_vendor_page',
                'meta_title_about_page',
            ]);
        });
    }
};
