<script>
$(document).ready(function() {
    $(document).on('click', '.generate-seo-btn', function() {
        var btn = $(this);
        var lang = btn.data('lang');
        var langName = btn.data('lang-name');
        var name = $('#in_' + lang + '_name').val();

        if (!name) {
            swal({
                title: 'Warning',
                text: 'Please enter the category name first.',
                type: 'warning',
            });
            return;
        }

        btn.prop('disabled', true).html('<i class="fas fa-spinner fa-spin"></i> Generating...');

        $.ajax({
            url: '{{ route("admin.listing_specification.generate_category_seo") }}',
            method: 'POST',
            data: {
                _token: '{{ csrf_token() }}',
                name: name,
                lang_code: lang,
                lang_name: langName,
            },
            success: function(res) {
                if (res.status === 'success' && res.data) {
                    $('#in_' + lang + '_meta_title').val(res.data.meta_title || '');
                    $('#in_' + lang + '_meta_description').val(res.data.meta_description || '');
                    $('#in_' + lang + '_seo_text').val(res.data.seo_text || '');
                    swal({
                        title: 'Success',
                        text: 'SEO data generated successfully!',
                        type: 'success',
                        timer: 1500,
                        showConfirmButton: false,
                    });
                }
            },
            error: function(xhr) {
                var msg = 'Failed to generate SEO';
                if (xhr.responseJSON && xhr.responseJSON.error) {
                    msg = xhr.responseJSON.error;
                }
                swal({
                    title: 'Error',
                    text: msg,
                    type: 'error',
                });
            },
            complete: function() {
                btn.prop('disabled', false).html('<i class="fas fa-magic"></i> Generate SEO');
            }
        });
    });
});
</script>
