@php
    $recaptchaSettings = \App\Models\BasicSettings\Basic::query()
        ->select('google_recaptcha_site_key')
        ->first();
    $recaptchaInputId = 'recaptcha-' . \Illuminate\Support\Str::random(10);
@endphp
<input type="hidden" name="g-recaptcha-response" id="{{ $recaptchaInputId }}">
<p class="mt-1 text-danger d-none js-enterprise-recaptcha-error">
    {{ __('Please verify that you are not a robot.') }}
</p>
<script src="https://www.google.com/recaptcha/enterprise.js?render={{ urlencode($recaptchaSettings?->google_recaptcha_site_key ?? '') }}"></script>
<script>
  (() => {
    const form = document.getElementById('{{ $recaptchaInputId }}')?.form;
    const input = document.getElementById('{{ $recaptchaInputId }}');
    const error = form?.querySelector('.js-enterprise-recaptcha-error');
    if (!form || !input) return;

    form.addEventListener('submit', (event) => {
      if (form.dataset.recaptchaReady === '1') return;
      event.preventDefault();
      grecaptcha.enterprise.ready(async () => {
        try {
          input.value = await grecaptcha.enterprise.execute(
            @json($recaptchaSettings?->google_recaptcha_site_key ?? ''),
            { action: @json($action) }
          );
          form.dataset.recaptchaReady = '1';
          form.requestSubmit();
        } catch (exception) {
          error?.classList.remove('d-none');
        }
      });
    });
  })();
</script>
