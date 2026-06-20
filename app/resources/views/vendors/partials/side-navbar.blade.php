<div class="sidebar sidebar-style-2"
    data-background-color="{{ Session::get('vendor_theme_version') == 'light' ? 'white' : 'dark2' }}">
    <div class="sidebar-wrapper scrollbar scrollbar-inner">
        <div class="sidebar-content">
            <div class="user">
                <div class="avatar-sm float-left mr-2">
                    @if (Auth::guard('vendor')->user()->photo != null)
                        <img src="{{ asset('assets/admin/img/vendor-photo/' . Auth::guard('vendor')->user()->photo) }}"
                            alt="Vendor Image" class="avatar-img rounded-circle">
                    @else
                        <img src="{{ asset('assets/img/blank-user.jpg') }}" alt=""
                            class="avatar-img rounded-circle">
                    @endif
                </div>

                <div class="info">
                    <a data-toggle="collapse" href="#adminProfileMenu" aria-expanded="true">
                        <span>
                            {{ Auth::guard('vendor')->user()->username }}
                            <span class="user-level">{{ __('Vendor') }}</span>
                            <span class="caret"></span>
                        </span>
                    </a>

                    <div class="clearfix"></div>

                    <div class="collapse in" id="adminProfileMenu">
                        <ul class="nav">
                            <li>
                                <a href="{{ route('vendor.edit.profile') }}">
                                    <span class="link-collapse">{{ __('Edit Profile') }}</span>
                                </a>
                            </li>

                            <li>
                                <a href="{{ route('vendor.change_password') }}">
                                    <span class="link-collapse">{{ __('Change Password') }}</span>
                                </a>
                            </li>

                            <li>
                                <a href="{{ route('vendor.logout') }}">
                                    <span class="link-collapse">{{ __('Logout') }}</span>
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <ul class="nav nav-primary">
                {{-- search --}}
                <div class="row mb-3">
                    <div class="col-12">
                        <form>
                            <div class="form-group py-0">
                                <input name="term" type="text" class="form-control sidebar-search"
                                    placeholder="{{ __('Search Menu Here') . '...' }}">
                            </div>
                        </form>
                    </div>
                </div>

                {{-- dashboard --}}
                <li class="nav-item @if (request()->routeIs('vendor.dashboard')) active @endif">
                    <a href="{{ route('vendor.dashboard') }}">
                        <i class="la flaticon-paint-palette"></i>
                        <p>{{ __('Dashboard') }}</p>
                    </a>
                </li>

                {{-- Listing management --}}

                <li
                    class="nav-item @if (request()->routeIs('vendor.listing_management.listings')) active 
           @elseif (request()->routeIs('vendor.listing_management.create_listing')) active 
            @elseif (request()->routeIs('vendor.listing_management.listing.faq')) active 
            @elseif (request()->routeIs('vendor.listing_management.listing.business_hours')) active 
            @elseif (request()->routeIs('vendor.listing_management.listing.plugins')) active 
            @elseif (request()->routeIs('vendor.listing_management.manage_additional_specifications')) active 
            @elseif (request()->routeIs('vendor.listing_management.manage_social_link')) active 
            @elseif (request()->routeIs('vendor.listing_management.edit_listing')) active @endif">
                    <a data-toggle="collapse" href="#listingManagement">
                        <i class="fas fa-building"></i>
                        <p>{{ __('Listings Management') }}</p>
                        <span class="caret"></span>
                    </a>

                    <div id="listingManagement"
                        class="collapse 
              @if (request()->routeIs('vendor.listing_management.listings')) show 
              @elseif (request()->routeIs('vendor.listing_management.create_listing')) show 
              @elseif (request()->routeIs('vendor.listing_management.listing.faq')) show 
              @elseif (request()->routeIs('vendor.listing_management.listing.business_hours')) show 
              @elseif (request()->routeIs('vendor.listing_management.listing.plugins')) show 
              @elseif (request()->routeIs('vendor.listing_management.manage_additional_specifications')) show 
              @elseif (request()->routeIs('vendor.listing_management.manage_social_link')) show 
              @elseif (request()->routeIs('vendor.listing_management.edit_listing')) show @endif">
                        <ul class="nav nav-collapse">

                            <li
                                class="{{ request()->routeIs('vendor.listing_management.create_listing') ? 'active' : '' }}">
                                <a
                                    href="{{ route('vendor.listing_management.create_listing', ['language' => $defaultLang->code]) }}">
                                    <span class="sub-item">{{ __('Add Listing') }}</span>
                                </a>
                            </li>

                            <li
                                class=" @if (request()->routeIs('vendor.listing_management.listings')) active
                   @elseif (request()->routeIs('vendor.listing_management.edit_listing')) active 
                   @elseif (request()->routeIs('vendor.listing_management.listing.business_hours')) active 
                   @elseif (request()->routeIs('vendor.listing_management.listing.faq')) active 
                   @elseif (request()->routeIs('vendor.listing_management.listing.plugins')) active 
                   @elseif (request()->routeIs('vendor.listing_management.manage_social_link')) active 
                   @elseif (request()->routeIs('vendor.listing_management.manage_additional_specifications')) active @endif">
                                <a
                                    href="{{ route('vendor.listing_management.listings', ['language' => $defaultLang->code]) }}">
                                    <span class="sub-item">{{ __('Manage Listings') }}</span>
                                </a>
                            </li>
                        </ul>
                    </div>
                </li>

                {{-- End Listing management --}}

                @php
                    $vendorId = Auth::guard('vendor')->user()->id;

                    if ($vendorId) {
                        $current_package = App\Http\Helpers\VendorPermissionHelper::packagePermission($vendorId);

                        if ($current_package != '[]') {
                            $numberoffImages = $current_package->number_of_images_per_listing;
                        } else {
                            $numberoffImages = 0;
                        }
                        if (!empty($current_package) && !empty($current_package->features)) {
                            $permissions = json_decode($current_package->features, true);
                        } else {
                            $permissions = null;
                        }
                    } else {
                        $permissions = null;
                    }
                @endphp


            @if(is_array($permissions) && in_array('Products', $permissions))
                <li class="nav-item @if (request()->routeIs('vendor.shop_management.tax_amount') ||

                        request()->routeIs('vendor.shop_management.product.categories') ||
                        request()->routeIs('vendor.shop_management.products') ||
                        request()->routeIs('vendor.shop_management.select_product_type') ||
                        request()->routeIs('vendor.shop_management.create_product') ||
                        request()->routeIs('vendor.shop_management.edit_product') ||
                        request()->routeIs('vendor.shop_management.orders') ||
                        request()->routeIs('vendor.shop_management.order.details') ||
                        request()->routeIs('vendor.listing_management.listing.choose_listing') ||
                        request()->routeIs('vendor.shop_management.products') ||
                        // request()->routeIs('vendor.listing_management.listing.products') ||
                        request()->routeIs('vendor.listing_management.create_Product') ||
                        request()->routeIs('vendor.listing_management.edit_product') ||
                        request()->routeIs('vendor.listings-management.form.index') ||
                        request()->routeIs('vendor.listings-management.form.input') ||
                        request()->routeIs('vendor.listings-management.form.edit_input') ||
                        request()->routeIs('vendor.shop_management.report')) active @endif">
                    <a data-toggle="collapse" href="#vendor-shop">
                        <i class="fal fa-store-alt"></i>
                        <p>{{ __('Shop Management') }}</p>
                        <span class="caret"></span>
                    </a>

                    <div id="vendor-shop" class="collapse @if (request()->routeIs('vendor.shop_management.tax_amount') ||

                            request()->routeIs('vendor.shop_management.product.categories') ||
                            request()->routeIs('vendor.shop_management.products') ||
                            request()->routeIs('vendor.shop_management.select_product_type') ||
                            request()->routeIs('vendor.shop_management.create_product') ||
                            request()->routeIs('vendor.shop_management.edit_product') ||
                            request()->routeIs('vendor.shop_management.orders') ||
                            request()->routeIs('vendor.shop_management.order.details') ||
                            request()->routeIs('vendor.listing_management.listing.choose_listing') ||
                            request()->routeIs('vendor.shop_management.products') ||
                            request()->routeIs('vendor.listing_management.create_Product') ||
                            request()->routeIs('vendor.listing_management.edit_product') ||
                            request()->routeIs('vendor.listings-management.form.index') ||
                            request()->routeIs('vendor.listings-management.form.input') ||
                            request()->routeIs('vendor.listings-management.form.edit_input') ||
                            request()->routeIs('vendor.shop_management.report')) show @endif">
                        <ul class="nav nav-collapse">
                            <li class="@if (request()->routeIs('vendor.shop_management.product.categories') ||
                                    request()->routeIs('vendor.shop_management.products') ||
                                    request()->routeIs('vendor.shop_management.select_product_type') ||
                                    request()->routeIs('vendor.shop_management.create_product') ||
                                    request()->routeIs('vendor.listing_management.listing.choose_listing') ||
                                    request()->routeIs('vendor.listing_management.create_Product') ||
                                    request()->routeIs('vendor.listing_management.edit_product') ||
                                    request()->routeIs('vendor.shop_management.edit_product')) active @endif">
                                <a
                                    href="{{ route('vendor.shop_management.products', ['language' => $defaultLang->code]) }}">
                                    <span class="sub-item">{{ __('Products') }}</span>
                                </a>
                            </li>
                            <li class="@if (request()->routeIs('vendor.listings-management.form.index') || request()->routeIs('vendor.listings-management.form.input') || request()->routeIs('vendor.listings-management.form.edit_input')) active @endif">
                                <a href="{{ route('vendor.listings-management.form.index') }}">
                                    <span class="sub-item">{{ __('Form') }}</span>
                                </a>
                            </li>
                            <li class="@if (request()->routeIs('vendor.shop_management.orders') || request()->routeIs('vendor.shop_management.order.details')) active @endif">
                                <a href="{{ route('vendor.shop_management.orders') }}">
                                    <span class="sub-item">{{ __('Orders') }}</span>
                                </a>
                            </li>
                        </ul>
                    </div>
                </li>
            @endif

                {{-- Messages --}}

                @if (
                    (is_array($permissions) && in_array('Listing Enquiry Form', $permissions)) ||
                        (is_array($permissions) &&
                            in_array('Product Enquiry Form', $permissions) &&
                            (is_array($permissions) && in_array('Products', $permissions))))
                    <li
                        class="nav-item @if (request()->routeIs('vendor.listing.messages')) active 
            @elseif (request()->routeIs('vendor.product.messages')) active 
            @elseif (request()->routeIs('vendor.product.message.details')) active 
            @endif">
                        <a data-toggle="collapse" href="#messages">
                            <i class="fas fa-comment"></i>
                            <p>{{ __('Messages') }}</p>
                            <span class="caret"></span>
                        </a>

                        <div id="messages"
                            class="collapse 
              @if (request()->routeIs('vendor.listing.messages')) show 
              @elseif (request()->routeIs('vendor.product.messages')) show 
              @elseif (request()->routeIs('vendor.product.message.details')) show 
              @endif">
                            <ul class="nav nav-collapse">
                                @if (is_array($permissions) && in_array('Listing Enquiry Form', $permissions))
                                    <li class="{{ request()->routeIs('vendor.listing.messages') ? 'active' : '' }}">
                                        <a
                                            href="{{ route('vendor.listing.messages', ['language' => $defaultLang->code]) }}">
                                            <span class="sub-item">{{ __('Listing Messages') }}</span>
                                        </a>
                                    </li>
                                @endif
                                @if (is_array($permissions) && in_array('Products', $permissions))
                                    @if (is_array($permissions) && in_array('Product Enquiry Form', $permissions))
                                        <li class=" @if (request()->routeIs('vendor.product.messages')) active @elseif(request()->routeIs('vendor.product.message.details')) active @endif">
                                            <a
                                                href="{{ route('vendor.product.messages', ['language' => $defaultLang->code]) }}">
                                                <span class="sub-item">{{ __('Product Messages') }}</span>
                                            </a>
                                        </li>
                                    @endif
                                @endif
                            </ul>
                        </div>
                    </li>
                @endif


                @php
                    $support_status = DB::table('support_ticket_statuses')->first();
                @endphp
                @if ($support_status->support_ticket_status == 'active')
                    {{-- Support Ticket --}}
                    <li
                        class="nav-item @if (request()->routeIs('vendor.support_tickets')) active
            @elseif (request()->routeIs('vendor.support_tickets.message')) active
            @elseif (request()->routeIs('vendor.support_ticket.create')) active @endif">
                        <a data-toggle="collapse" href="#support_ticket">
                            <i class="la flaticon-web-1"></i>
                            <p>{{ __('Support Tickets') }}</p>
                            <span class="caret"></span>
                        </a>

                        <div id="support_ticket"
                            class="collapse
              @if (request()->routeIs('vendor.support_tickets')) show
              @elseif (request()->routeIs('vendor.support_tickets.message')) show
              @elseif (request()->routeIs('vendor.support_ticket.create')) show @endif">
                            <ul class="nav nav-collapse">

                                <li
                                    class="{{ request()->routeIs('vendor.support_tickets') && empty(request()->input('status')) ? 'active' : '' }}">
                                    <a href="{{ route('vendor.support_tickets') }}">
                                        <span class="sub-item">{{ __('All Tickets') }}</span>
                                    </a>
                                </li>
                                <li class="{{ request()->routeIs('vendor.support_ticket.create') ? 'active' : '' }}">
                                    <a href="{{ route('vendor.support_ticket.create') }}">
                                        <span class="sub-item">{{ __('Add a Ticket') }}</span>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </li>
                @endif
                {{-- dashboard --}}
                <li
                    class="nav-item 
        @if (request()->routeIs('vendor.plan.extend.index')) active 
        @elseif (request()->routeIs('vendor.plan.extend.checkout')) active @endif">
                    <a href="{{ route('vendor.plan.extend.index') }}">
                        <i class="fal fa-lightbulb-dollar"></i>
                        <p>{{ __('Buy Plan') }}</p>
                    </a>
                </li>

                <li class="nav-item @if (request()->routeIs('vendor.payment_log')) active @endif">
                    <a href="{{ route('vendor.payment_log') }}">
                        <i class="fas fa-list-ol"></i>
                        <p>{{ __('Payment Logs') }}</p>
                    </a>
                </li>
                {{-- Withdrawals --}}
                <li class="nav-item 
                    @if (request()->routeIs('vendor.withdraw')) active
                    @elseif (request()->routeIs('vendor.withdraw.create')) active
                    @elseif (request()->routeIs('vendor.withdraw.send-request')) active
                    @elseif (request()->routeIs('vendor.withdraw.bulk_delete_withdraw')) active
                    @elseif (request()->routeIs('vendor.withdraw.delete_withdraw')) active @endif">
                    <a data-toggle="collapse" href="#Withdrawals">
                        <i class="fal fa-donate"></i>
                        <p>{{ __('Withdrawals') }}</p>
                        <span class="caret"></span>
                    </a>
                    <div id="Withdrawals" 
                        class="collapse 
                        @if (request()->routeIs('vendor.withdraw')) show
                        @elseif (request()->routeIs('vendor.withdraw.create')) show
                        @elseif (request()->routeIs('vendor.withdraw.send-request')) show
                        @elseif (request()->routeIs('vendor.withdraw.bulk_delete_withdraw')) show
                        @elseif (request()->routeIs('vendor.withdraw.delete_withdraw')) show @endif">
                        <ul class="nav nav-collapse">
                            <li class="@if (request()->routeIs('vendor.withdraw') || 
                                        request()->routeIs('vendor.withdraw.bulk_delete_withdraw') || 
                                        request()->routeIs('vendor.withdraw.delete_withdraw')) active @endif">
                                <a href="{{ route('vendor.withdraw', ['language' => $defaultLang->code]) }}">
                                    <span class="sub-item">{{ __('Withdrawal Requests') }}</span>
                                </a>
                            </li>

                            <li class="{{ request()->routeIs('vendor.withdraw.create') || request()->routeIs('vendor.withdraw.send-request') ? 'active' : '' }}">
                                <a href="{{ route('vendor.withdraw.create', ['language' => $defaultLang->code]) }}">
                                    <span class="sub-item">{{ __('Make a Request') }}</span>
                                </a>
                            </li>
                        </ul>
                    </div>
                </li>
                <li class="nav-item @if (request()->routeIs('vendor.edit.profile')) active @endif">
                    <a href="{{ route('vendor.edit.profile') }}">
                        <i class="fal fa-user-edit"></i>
                        <p>{{ __('Edit Profile') }}</p>
                    </a>
                </li>
                <li class="nav-item  @if (request()->routeIs('vendor.email_setting.mail_to_admin')) active @endif">
                    <a href="{{ route('vendor.email_setting.mail_to_admin') }}">
                        <i class="far fa-envelope"></i>
                        <p>{{ __('Recipient mail') }}</p>
                    </a>
                </li>
                <li class="nav-item @if (request()->routeIs('vendor.change_password')) active @endif">
                    <a href="{{ route('vendor.change_password') }}">
                        <i class="fal fa-key"></i>
                        <p>{{ __('Change Password') }}</p>
                    </a>
                </li>

                <li class="nav-item @if (request()->routeIs('vendor.logout')) active @endif">
                    <a href="{{ route('vendor.logout') }}">
                        <i class="fal fa-sign-out"></i>
                        <p>{{ __('Logout') }}</p>
                    </a>
                </li>
            </ul>
        </div>
    </div>
</div>
