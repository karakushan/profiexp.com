<script>
  'use strict';
  const baseUrl = "{{ asset('/') }}";
  let demo_mode = "{{ env('DEMO_MODE') }}";
  var Selectacountry = "{{ __('Select a country') }}";
  var Selectastate = "{{ __('Select a state') }}";
  var SocialLink = "{{ __('Social Link') }}";
  var SelectIcon = "{{ __('Select Icon') }}";
  var AddOption = "{{ __('Add Option') }}";
  var Value = "{{ __('Value') }}";
  var In = "{{ __('In') }}";
  var Label = "{{ __('Label') }}";
  let sucessText = "{{ __('Success') }}";
  let warningText = "{{ __('Warning') }}";
  let Areyousure = "{{ __('Are you sure') . '?' }}";
  let YourPackagelimitreachedorexceeded = "{{ __('Your Package limit reached or exceeded') . '!' }}";
  let Yesdeleteit = "{{ __('Yes, delete it') }}";
  let Youwontbeabletorevertthis = "{{ __('You won\'t be able to revert this') }}";
  let Ifyoudeletethispackageallmembershipsunderthispackagewillbedeleted =
    "{{ __('If you delete this package, all memberships under this package will be deleted') }}";
  let Youwanttoclosethisticket = "{{ __('You want to close this ticket') }}";
  let Yescloseit = "{{ __('Yes, close it') }}";
  let Alert = "{{ __('Alert') }}";
  let PleaseBuyaplantoaddalisting = "{{ __('Please Buy a plan to add a listing') . '!' }}";
  let Listingslimitreachedorexceeded = "{{ __('Listings limit reached or exceeded') . '!' }}";
  let cancelText = "{{ __('cancel')  }}";

  @if ($settings->time_format == 24)
    var timePicker = true;
    var timeFormate = "HH:mm";
  @elseif ($settings->time_format == 12)
    var timePicker = false;
    var timeFormate = "hh:mm A";
  @endif
</script>

{{-- core js files --}}
<script type="text/javascript" src="{{ asset('assets/admin/js/jquery.min.js') }}"></script>
<script type="text/javascript" src="{{ asset('assets/admin/js/popper.min.js') }}"></script>
<script type="text/javascript" src="{{ asset('assets/admin/js/bootstrap.min.js') }}"></script>

{{-- jQuery ui --}}
<script type="text/javascript" src="{{ asset('assets/admin/js/jquery-ui.min.js') }}"></script>
<script type="text/javascript" src="{{ asset('assets/admin/js/jquery.ui.touch-punch.min.js') }}"></script>

{{-- jQuery time-picker --}}
<script type="text/javascript" src="{{ asset('assets/admin/js/jquery.timepicker.min.js') }}"></script>

{{-- jQuery scrollbar --}}
<script type="text/javascript" src="{{ asset('assets/admin/js/jquery.scrollbar.min.js') }}"></script>

{{-- bootstrap notify --}}
<script type="text/javascript" src="{{ asset('assets/admin/js/bootstrap-notify.min.js') }}"></script>

{{-- sweet alert --}}
<script type="text/javascript" src="{{ asset('assets/admin/js/sweet-alert.min.js') }}"></script>

{{-- bootstrap tags input --}}
<script type="text/javascript" src="{{ asset('assets/admin/js/bootstrap-tagsinput.min.js') }}"></script>

{{-- bootstrap date-picker --}}
<script type="text/javascript" src="{{ asset('assets/admin/js/bootstrap-datepicker.min.js') }}"></script>

{{-- tinymce editor --}}
<script src="{{ asset('assets/admin/js/tinymce/js/tinymce/tinymce.min.js') }}"></script>

{{-- js color --}}
<script type="text/javascript" src="{{ asset('assets/admin/js/jscolor.min.js') }}"></script>

{{-- fontawesome icon picker js --}}
<script type="text/javascript" src="{{ asset('assets/admin/js/fontawesome-iconpicker.min.js') }}"></script>

{{-- datatables js --}}
<script type="text/javascript" src="{{ asset('assets/admin/js/datatables-1.10.23.min.js') }}"></script>

{{-- datatables bootstrap js --}}
<script type="text/javascript" src="{{ asset('assets/admin/js/datatables.bootstrap4.min.js') }}"></script>

{{-- dropzone js --}}
<script type="text/javascript" src="{{ asset('assets/admin/js/dropzone.min.js') }}"></script>

{{-- atlantis js --}}
<script type="text/javascript" src="{{ asset('assets/admin/js/atlantis.js') }}"></script>

{{-- fonts and icons script --}}
<script type="text/javascript" src="{{ asset('assets/admin/js/webfont.min.js') }}"></script>

<!-- Date-range Picker JS -->
<script src="{{ asset('assets/admin/js/moment.min.js') }}"></script>
<script src="{{ asset('assets/admin/js/daterangepicker.min.js') }}"></script>

@if (session()->has('success'))
  <script>
    'use strict';
    var content = {};

    content.message = '{{ session('success') }}';
    content.title = sucessText;
    content.icon = 'fa fa-bell';

    $.notify(content, {
      type: 'success',
      placement: {
        from: 'top',
        align: 'right'
      },
      showProgressbar: true,
      time: 1000,
      delay: 4000
    });
  </script>
@endif

@if (session()->has('warning'))
  <script>
    'use strict';
    var content = {};

    content.message = "{{ session('warning') }}";
    content.title = warningText;
    content.icon = 'fa fa-bell';

    $.notify(content, {
      type: 'warning',
      placement: {
        from: 'top',
        align: 'right'
      },
      showProgressbar: true,
      time: 1000,
      delay: 4000
    });
  </script>
@endif


<script>
  'use strict';
  const account_status = 1;
  const secret_login = 1;
</script>

{{-- select2 js --}}
<script type="text/javascript" src="{{ asset('assets/admin/js/select2.min.js') }}"></script>

{{-- admin-main js --}}
<script type="text/javascript" src="{{ asset('assets/admin/js/admin-main.js') }}"></script>
<script type="text/javascript" src="{{ asset('assets/admin/js/admin-partial.js') }}"></script>
