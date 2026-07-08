<!-- Header-area start -->
<header class="header-area header-2" data-aos="slide-down">
  <!-- Start mobile menu -->
  <div class="mobile-menu">
    <div class="container">
      <div class="mobile-menu-wrapper"></div>
    </div>
  </div>
  <!-- End mobile menu -->

  <div class="main-responsive-nav">
    <div class="container">
      <!-- Mobile Logo -->
      <div class="logo">
        @if (!empty($websiteInfo->logo))
          <a href="{{ route('index') }}">
            <img src="{{ asset('assets/img/' . $websiteInfo->logo) }}" alt="logo">
          </a>
        @endif
      </div>
      <div class="mobile-right-group">
        <!-- Mobile Language Switcher -->
        <div class="mobile-lang">
          <button class="mobile-lang-btn" type="button">
            <span class="lang-code">{{ strtoupper($currentLanguageInfo->code) }}</span>
            <i class="fal fa-angle-down"></i>
          </button>
          <ul class="mobile-lang-dropdown">
            @foreach ($allLanguageInfos as $languageInfo)
              <li>
                <a href="#" data-lang="{{ $languageInfo->code }}"
                  class="{{ $languageInfo->code == $currentLanguageInfo->code ? 'active' : '' }}">
                  {{ $languageInfo->name }}
                </a>
              </li>
            @endforeach
          </ul>
          <form action="{{ route('change_language') }}" method="GET" class="d-none">
            <input type="hidden" name="current_url" value="{{ url()->full() }}">
            <input type="hidden" name="lang_code" value="">
          </form>
        </div>
        <!-- Menu toggle button -->
        <button class="menu-toggler" type="button">
          <span></span>
          <span></span>
          <span></span>
        </button>
      </div>
    </div>
  </div>
  <div class="main-navbar">
    <div class="container">
      <nav class="navbar navbar-expand-lg">
        <!-- Logo -->
        <a class="navbar-brand" href="{{ route('index') }}">
          <img src="{{ asset('assets/img/' . $websiteInfo->logo) }}" alt="logo">
        </a>
        <!-- Navigation items -->
        <div class="collapse navbar-collapse">
          @php $menuDatas = json_decode($menuInfos); @endphp
          <ul id="mainMenu" class="navbar-nav mobile-item mx-auto">
            @foreach ($menuDatas as $menuData)
              @php $href = get_href($menuData); @endphp
              @if (!property_exists($menuData, 'children'))
                <li class="nav-item">
                  <a class="nav-link" href="{{ $href }}">{{ $menuData->text }}</a>
                </li>
              @else
                <li class="nav-item">
                  <a class="nav-link toggle" href="{{ $href }}">{{ $menuData->text }}<i
                      class="fal fa-plus"></i></a>
                  <ul class="menu-dropdown">
                    @php $childMenuDatas = $menuData->children; @endphp
                    @foreach ($childMenuDatas as $childMenuData)
                      @php $child_href = get_href($childMenuData); @endphp
                      <li class="nav-item">
                        <a class="nav-link" href="{{ $child_href }}">{{ $childMenuData->text }}</a>
                      </li>
                    @endforeach
                  </ul>
                </li>
              @endif
            @endforeach
          </ul>
        </div>
        <div class="more-option mobile-item">
          <div class="item item-language">
            <div class="language">
              <form action="{{ route('change_language') }}" method="GET">
                <input type="hidden" name="current_url" value="{{ url()->full() }}">
                <select class="niceselect" name="lang_code" onchange="this.form.submit()">
                  @foreach ($allLanguageInfos as $languageInfo)
                    <option value="{{ $languageInfo->code }}"
                      {{ $languageInfo->code == $currentLanguageInfo->code ? 'selected' : '' }}>
                      {{ $languageInfo->name }}
                    </option>
                  @endforeach
                </select>
              </form>
            </div>
          </div>
          <div class="item">
            <div class="dropdown">
              <button class="btn btn-outline btn-md radius-sm dropdown-toggle" type="button" data-bs-toggle="dropdown"
                aria-expanded="false">
                @if (!Auth::guard('web')->check())
                  {{ __('Customer') }}
                @else
                  {{ Auth::guard('web')->user()->username }}
                @endif
              </button>
              <ul class="dropdown-menu radius-sm text-transform-normal">
                @if (!Auth::guard('web')->check())
                  <li><a class="dropdown-item" href="{{ route('user.login') }}">{{ __('Login') }}</a></li>
                  <li><a class="dropdown-item" href="{{ route('user.signup') }}">{{ __('Signup') }}</a></li>
                @else
                  <li><a class="dropdown-item" href="{{ route('user.dashboard') }}">{{ __('Dashboard') }}</a></li>
                  <li><a class="dropdown-item" href="{{ route('user.logout') }}">{{ __('Logout') }}</a></li>
                @endif
              </ul>
            </div>
          </div>
          <div class="item">
            <div class="dropdown">
              <button class="btn btn-primary btn-md dropdown-toggle" type="button" data-bs-toggle="dropdown"
                aria-expanded="false">
                @if (!Auth::guard('vendor')->check())
                  {{ __('Vendor') }}
                @else
                  {{ Auth::guard('vendor')->user()->username }}
                @endif
              </button>
              <ul class="dropdown-menu radius-0">
                @if (!Auth::guard('vendor')->check())
                  <li><a class="dropdown-item" href="{{ route('vendor.login') }}">{{ __('Login') }}</a></li>
                  <li><a class="dropdown-item" href="{{ route('vendor.signup') }}">{{ __('Signup') }}</a></li>
                @else
                  <li><a class="dropdown-item" href="{{ route('vendor.dashboard') }}">{{ __('Dashboard') }}</a></li>

                  <li><a class="dropdown-item" href="{{ route('vendor.logout') }}">{{ __('Logout') }}</a></li>
                @endif
              </ul>
            </div>
          </div>

        </div>
      </nav>
    </div>
    <div class="category-navbar mobile-item">
      <div class="container">
        <ul class="category-nav-list">
          @php
            $displayCategories = $headerCategories->take(5);
            $moreCategories = $headerCategories->slice(5);
          @endphp
          @foreach ($displayCategories as $category)
            <li class="category-nav-item {{ $category->children->isNotEmpty() ? 'has-dropdown' : '' }}">
              <a href="{{ listing_category_url($category, $currentLanguageInfo->code) }}"
                class="category-nav-link {{ $category->children->isNotEmpty() ? 'toggle' : '' }}">
                <span class="category-icon-box"><i class="{{ $category->icon ?: 'fal fa-folder' }}"></i></span>
                <span class="category-name">{{ $category->getName($currentLanguageInfo->id) }}</span>
                @if ($category->children->isNotEmpty())
                  <i class="fal fa-angle-down category-arrow"></i>
                @endif
              </a>
              @if ($category->children->isNotEmpty())
                <ul class="category-dropdown multi-column">
                  @foreach ($category->children->chunk(5) as $chunk)
                    <li class="dropdown-column">
                      <ul>
                        @foreach ($chunk as $child)
                          <li>
                            <a href="{{ listing_category_url($child, $currentLanguageInfo->code) }}">
                              <span class="category-icon-box sm"><i class="{{ $child->icon ?: 'fal fa-folder' }}"></i></span>
                              {{ $child->getName($currentLanguageInfo->id) }}
                            </a>
                          </li>
                        @endforeach
                      </ul>
                    </li>
                  @endforeach
                </ul>
              @endif
            </li>
          @endforeach
          @if ($moreCategories->isNotEmpty())
            <li class="category-nav-item has-dropdown more-categories">
              <a href="javascript:void(0)" class="category-nav-link toggle">
                <span class="category-icon-box"><i class="fal fa-ellipsis-h"></i></span>
                <span class="category-name">{{ __('More Categories') }}</span>
                <i class="fal fa-angle-down category-arrow"></i>
              </a>
              <ul class="category-dropdown category-dropdown-wide multi-column">
                @foreach ($moreCategories->chunk(5) as $chunk)
                  <li class="dropdown-column">
                    <ul>
                      @foreach ($chunk as $category)
                        <li class="{{ $category->children->isNotEmpty() ? 'has-submenu' : '' }}">
                          <a href="{{ listing_category_url($category, $currentLanguageInfo->code) }}">
                            <span class="category-icon-box sm"><i class="{{ $category->icon ?: 'fal fa-folder' }}"></i></span>
                            {{ $category->getName($currentLanguageInfo->id) }}
                          </a>
                          @if ($category->children->isNotEmpty())
                            <ul class="category-submenu">
                              @foreach ($category->children as $child)
                                <li>
                                  <a href="{{ listing_category_url($child, $currentLanguageInfo->code) }}">
                                    <span class="category-icon-box sm"><i class="{{ $child->icon ?: 'fal fa-folder' }}"></i></span>
                                    {{ $child->getName($currentLanguageInfo->id) }}
                                  </a>
                                </li>
                              @endforeach
                            </ul>
                          @endif
                        </li>
                      @endforeach
                    </ul>
                  </li>
                @endforeach
              </ul>
            </li>
          @endif
        </ul>
      </div>
    </div>
  </div>
</header>
<!-- Header-area end -->
