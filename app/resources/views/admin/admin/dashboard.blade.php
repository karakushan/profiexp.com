@extends('admin.layout')

@section('content')
  <div class="mt-2 mb-4">
    <h2 class="pb-2">{{ __('Welcome back') . ',' }} {{ $authAdmin->first_name . ' ' . $authAdmin->last_name . '!' }}</h2>
  </div>

  {{-- dashboard information start --}}
  @php
    if (!is_null($roleInfo)) {
        $rolePermissions = json_decode($roleInfo->permissions);
    }
  @endphp

  <div class="row dashboard-items">

    @if (is_null($roleInfo) || (!empty($rolePermissions) && in_array('Listing Managements', $rolePermissions)))
      <div class="col-sm-6 col-md-3">
        <a href="{{ route('admin.listing_management.listings', ['language' => $defaultLang->code]) }}">
          <div class="card card-stats card-success card-round">
            <div class="card-body">
              <div class="row">
                <div class="col-5">
                  <div class="icon-big text-center">
                    <i class="fas fa-building"></i>
                  </div>
                </div>
                <div class="col-7 col-stats">
                  <div class="numbers">
                    <p class="card-category">{{ __('Listings') }}</p>
                    <h4 class="card-title">{{ $totalListings }}</h4>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </a>
      </div>
    @endif

    @if (is_null($roleInfo) || (!empty($rolePermissions) && in_array('Subscription Log', $rolePermissions)))
      <div class="col-sm-6 col-md-3">
        <a href="{{ route('admin.payment-log.index') }}">
          <div class="card card-stats card-primary card-round">
            <div class="card-body">
              <div class="row">
                <div class="col-5">
                  <div class="icon-big text-center">
                    <i class="fas fa-money-check-alt"></i>
                  </div>
                </div>

                <div class="col-7 col-stats">
                  <div class="numbers">
                    <p class="card-category">{{ __('Subscription Log') }}</p>
                    <h4 class="card-title">{{ $payment_log }}
                    </h4>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </a>
      </div>
    @endif

    @if (is_null($roleInfo) || (!empty($rolePermissions) && in_array('Shop Management', $rolePermissions)))
      <div class="col-sm-6 col-md-3">
        <a href="{{ route('admin.shop_management.products', ['language' => $defaultLang->code]) }}">
          <div class="card card-stats card-primary card-round">
            <div class="card-body">
              <div class="row">
                <div class="col-5">
                  <div class="icon-big text-center">
                    <i class="fal fa-box-alt"></i>
                  </div>
                </div>

                <div class="col-7 col-stats">
                  <div class="numbers">
                    <p class="card-category">{{ __('Products') }}</p>
                    <h4 class="card-title">{{ $totalProduct }}</h4>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </a>
      </div>
    @endif

    @if (is_null($roleInfo) || (!empty($rolePermissions) && in_array('Shop Management', $rolePermissions)))
      <div class="col-sm-6 col-md-3">
        <a href="{{ route('admin.shop_management.orders') }}">
          <div class="card card-stats card-warning card-round">
            <div class="card-body">
              <div class="row">
                <div class="col-5">
                  <div class="icon-big text-center">
                    <i class="fal fa-shopping-cart"></i>
                  </div>
                </div>

                <div class="col-7 col-stats">
                  <div class="numbers">
                    <p class="card-category">{{ __('Orders') }}</p>
                    <h4 class="card-title">{{ $totalOrder }}</h4>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </a>
      </div>
    @endif

    @if (is_null($roleInfo) || (!empty($rolePermissions) && in_array('Blog Management', $rolePermissions)))
      <div class="col-sm-6 col-md-3">
        <a href="{{ route('admin.blog_management.blogs', ['language' => $defaultLang->code]) }}">
          <div class="card card-stats card-info card-round">
            <div class="card-body">
              <div class="row">
                <div class="col-5">
                  <div class="icon-big text-center">
                    <i class="fal fa-blog"></i>
                  </div>
                </div>

                <div class="col-7 col-stats">
                  <div class="numbers">
                    <p class="card-category">{{ __('Blog') }}</p>
                    <h4 class="card-title">{{ $totalBlog }}</h4>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </a>
      </div>
    @endif

    @if (is_null($roleInfo) || (!empty($rolePermissions) && in_array('Vendors Management', $rolePermissions)))
      <div class="col-sm-6 col-md-3">
        <a href="{{ route('admin.vendor_management.registered_vendor') }}">
          <div class="card card-stats card-secondary card-round">
            <div class="card-body">
              <div class="row">
                <div class="col-5">
                  <div class="icon-big text-center">
                    <i class="fas fa-users"></i>
                  </div>
                </div>
                <div class="col-7 col-stats">
                  <div class="numbers">
                    <p class="card-category">{{ __('Vendors') }}</p>
                    <h4 class="card-title">
                      {{ $vendors }}
                    </h4>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </a>
      </div>
    @endif

    @if (is_null($roleInfo) || (!empty($rolePermissions) && in_array('User Management', $rolePermissions)))
      <div class="col-sm-6 col-md-3">
        <a href="{{ route('admin.user_management.registered_users') }}">
          <div class="card card-stats card-orchid card-round">
            <div class="card-body">
              <div class="row">
                <div class="col-5">
                  <div class="icon-big text-center">
                    <i class="la flaticon-users"></i>
                  </div>
                </div>

                <div class="col-7 col-stats">
                  <div class="numbers">
                    <p class="card-category">{{ __('Users') }}</p>
                    <h4 class="card-title">{{ $totalUser }}</h4>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </a>
      </div>
    @endif

    @if (is_null($roleInfo) || (!empty($rolePermissions) && in_array('User Management', $rolePermissions)))
      <div class="col-sm-6 col-md-3">
        <a href="{{ route('admin.user_management.subscribers') }}">
          <div class="card card-stats card-dark card-round">
            <div class="card-body">
              <div class="row">
                <div class="col-5">
                  <div class="icon-big text-center">
                    <i class="fal fa-bell"></i>
                  </div>
                </div>

                <div class="col-7 col-stats">
                  <div class="numbers">
                    <p class="card-category">{{ __('Subscribers') }}</p>
                    <h4 class="card-title">{{ $totalSubscriber }}</h4>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </a>
      </div>
    @endif

        {{-- Required AI Tokens Box --}}

    @php
        $tokenTooltipText =
            '<div class="ai-tooltip-content">' .
            '<div class="ai-tooltip-title">' .
            __('AI Token Statistics') .
            ' (' .
            __('All Active Vendors') .
            ')' .
            '</div>' .
            '<div class="ai-tooltip-item">' .
            '<div class="ai-tooltip-label">' . __('Scope') . '</div>' .
            '<div class="ai-tooltip-text">' . __('This data is calculated by combining all ACTIVE vendor memberships only') . '.</div>' .
            '</div>' .
            '<div class="ai-tooltip-item">' .
            '<div class="ai-tooltip-label">' . __('Required AI Tokens') . '</div>' .
            '<div class="ai-tooltip-text">' . __('Total allocated tokens for this AI engine across all active vendor plans') . '.</div>' .
            '</div>' .
            '<div class="ai-tooltip-item">' .
            '<div class="ai-tooltip-label">' . __('Used AI Tokens') . '</div>' .
            '<div class="ai-tooltip-text">' . __('Total number of tokens already used by all vendor users under this AI engine') . '.</div>' .
            '</div>' .
            '<div class="ai-tooltip-item">' .
            '<div class="ai-tooltip-label">' . __('Remaining AI Tokens') . '</div>' .
            '<div class="ai-tooltip-text">' . __('Remaining available tokens for all vendors combined') . '.</div>' .
            '</div>' .
            '<div class="ai-tooltip-item">' .
            '<div class="ai-tooltip-label">' . __('Important') . '</div>' .
            '<div class="ai-tooltip-text">' . __('These numbers represent combined usage across all vendors, not individual vendor limits') . '.</div>' .
            '</div>' .
            '</div>';
    @endphp

        @php
            $imageTooltipText =
                '<div class="ai-tooltip-content">' .
                '<div class="ai-tooltip-title">' .
                __('AI Image Statistics') .
                ' (' .
                __('All Active Vendors') .
                ')' .
                '</div>' .
                '<div class="ai-tooltip-item">' .
                '<div class="ai-tooltip-label">' . __('Scope') . '</div>' .
                '<div class="ai-tooltip-text">' . __('This data is calculated by combining all ACTIVE vendor memberships only') . '.</div>' .
                '</div>' .
                '<div class="ai-tooltip-item">' .
                '<div class="ai-tooltip-label">' . __('Required AI Images') . '</div>' .
                '<div class="ai-tooltip-text">' . __('Total image generation quota allocated for this AI engine across all active vendors') . '.</div>' .
                '</div>' .
                '<div class="ai-tooltip-item">' .
                '<div class="ai-tooltip-label">' . __('Used AI Images') . '</div>' .
                '<div class="ai-tooltip-text">' . __('Total number of AI-generated images already created by all vendor users') . '.</div>' .
                '</div>' .
                '<div class="ai-tooltip-item">' .
                '<div class="ai-tooltip-label">' . __('Remaining AI Images') . '</div>' .
                '<div class="ai-tooltip-text">' . __('Remaining available images for all vendors combined') . '.</div>' .
                '</div>' .
                '<div class="ai-tooltip-item">' .
                '<div class="ai-tooltip-label">' . __('Important') . '</div>' .
                '<div class="ai-tooltip-text">' . __('These numbers represent combined usage across all vendors, not individual vendor limits') . '.</div>' .
                '</div>' .
                '</div>';
        @endphp

        @if (!empty($aiEngineStats))
          <div class="col-12">
            <div class="row ai-dashboard-row">
              @foreach ($aiEngineStats as $key => $stat)
                <div class="col-sm-6 col-xl-3 d-flex">
                  <div class="card ai-card-v2 ai-card-token ai-card-{{ $key % 4 }} card-tooltip-trigger w-100"
                    data-card-tooltip="{{ e($tokenTooltipText) }}">
                    <div class="card-body">
                      <div class="ai-card-header">
                        <span class="ai-card-chip">{{ __('Token Usage') }}</span>
                        <h5 class="ai-card-title mb-0">{{ strtoupper($stat['engine']) }}</h5>
                      </div>

                      <div class="ai-card-content">
                        <div class="ai-card-icon">
                          <i class="fas fa-coins"></i>
                        </div>

                        <div class="ai-card-metrics">
                          <div class="ai-card-metric">
                            <span>{{ __('Required AI Tokens') }}</span>
                            <strong>{{ $stat['token_required'] }}</strong>
                          </div>
                          <div class="ai-card-metric">
                            <span>{{ __('Used AI Tokens') }}</span>
                            <strong>{{ $stat['token_used'] }}</strong>
                          </div>
                          <div class="ai-card-metric">
                            <span>{{ __('Remaining AI Tokens') }}</span>
                            <strong>{{ $stat['token_remaining'] }}</strong>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              @endforeach

              @foreach ($aiEngineStats as $key => $stat)
                <div class="col-sm-6 col-xl-3 d-flex">
                  <div class="card ai-card-v2 ai-card-image ai-card-{{ $key % 4 }} card-tooltip-trigger w-100"
                    data-card-tooltip="{{ e($imageTooltipText) }}">
                    <div class="card-body">
                      <div class="ai-card-header">
                        <span class="ai-card-chip">{{ __('Image Usage') }}</span>
                        <h5 class="ai-card-title mb-0">{{ strtoupper($stat['engine']) }}</h5>
                      </div>

                      <div class="ai-card-content">
                        <div class="ai-card-icon">
                          <i class="fas fa-image"></i>
                        </div>

                        <div class="ai-card-metrics">
                          <div class="ai-card-metric">
                            <span>{{ __('Required AI Images') }}</span>
                            <strong>{{ $stat['image_required'] }}</strong>
                          </div>
                          <div class="ai-card-metric">
                            <span>{{ __('Used AI Images') }}</span>
                            <strong>{{ $stat['image_used'] }}</strong>
                          </div>
                          <div class="ai-card-metric">
                            <span>{{ __('Remaining AI Images') }}</span>
                            <strong>{{ $stat['image_remaining'] }}</strong>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              @endforeach
            </div>
          </div>
        @endif
    {{-- AI Token Stats (one card per engine) --}}


    @if (is_null($roleInfo) || (!empty($rolePermissions) && in_array('Package Management', $rolePermissions)))
      <div class="col-sm-12 col-md-6">
        <div class="card">
          <div class="card-header">
            <div class="card-title">{{ __('Monthly Package Purchase') }} ({{ date('Y') }})</div>
          </div>
          <div class="card-body">
            <div class="chart-container">
              <canvas id="packagePurchaseChart"></canvas>
            </div>
          </div>
        </div>
      </div>
    @endif

    @if (is_null($roleInfo) || (!empty($rolePermissions) && in_array('User Management', $rolePermissions)))
      <div class="col-sm-12 col-md-6">
        <div class="card">
          <div class="card-header">
            <div class="card-title">{{ __('Month wise registered users') }} ({{ date('Y') }})</div>
          </div>
          <div class="card-body">
            <div class="chart-container">
              <canvas id="userChart"></canvas>
            </div>
          </div>
        </div>
      </div>
    @endif

  </div>

  {{-- dashboard information end --}}
@endsection

@section('script')
  <script>
    "use strict";
    const monthArr = @php echo json_encode($monthArr) @endphp;
    const packagePurchaseIncomesArr = @php echo json_encode($packagePurchaseIncomesArr) @endphp;
    const totalUsersArr = @php echo json_encode($totalUsersArr) @endphp;
    var Monthwiseregisteredusers = "{{ __('Month wise registered users') }}";
    var MonthlyPackagePurchase = "{{ __('Monthly Package Purchase') }}";
  </script>

  <script type="text/javascript" src="{{ asset('assets/admin/js/chart.min.js') }}"></script>
  <script type="text/javascript" src="{{ asset('assets/admin/js/chart-init.js') }}"></script>
@endsection
