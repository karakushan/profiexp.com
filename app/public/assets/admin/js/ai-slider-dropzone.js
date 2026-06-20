(function (window, $) {
  'use strict';
  if (!$) return console.error('ai-slider-dropzone requires jQuery');

  function csrfToken() {
    return document.querySelector('meta[name="csrf-token"]')?.getAttribute('content') || '';
  }

  function showErr(sel, msg) {
    const $b = $(sel);
    if ($b.length) $b.removeClass('d-none').text(msg || 'Something went wrong.');
  }

  function hideErr(sel) {
    const $b = $(sel);
    if ($b.length) $b.addClass('d-none').text('');
  }

  function val(sel) {
    if (!sel) return '';
    const $el = $(sel);
    return $el.length ? ($el.val() || '') : '';
  }

  function setIfExists(sel, value) {
    if (!sel) return;
    const $el = $(sel);
    if ($el.length) {
      $el.val(value).trigger('change');
    }
  }

  function finishPreview(dz, file, thumbnailUrl) {
    dz.emit('thumbnail', file, thumbnailUrl);
    dz.emit('complete', file);
    file.status = Dropzone.SUCCESS;
  }

  // Create a "fake" file preview in Dropzone from an image URL
  function addUrlToDropzone(dz, imageUrl, fileId, hiddenWrapSel, hiddenInputName, removeEndpoint, removePayloadKey) {
    // Create a mock file object
    const safeName = String(fileId || '').trim() || ('ai-' + Date.now() + '.jpg');
    const ext = safeName.split('.').pop().toLowerCase();
    const mime = ext === 'png' ? 'image/png' : (ext === 'gif' ? 'image/gif' : 'image/jpeg');
    const mockFile = {
      name: safeName,
      size: 12345,
      type: mime,
      accepted: true,
      status: Dropzone.ADDED,
      upload: { progress: 100, total: 12345, bytesSent: 12345 },
      dataURL: imageUrl
    };
    // Emit events to create preview
    dz.emit('addedfile', mockFile);
    if (typeof dz.createThumbnailFromUrl === 'function') {
      dz.createThumbnailFromUrl(
        mockFile,
        dz.options.thumbnailWidth,
        dz.options.thumbnailHeight,
        dz.options.thumbnailMethod,
        true,
        function (thumbnailUrl) {
          finishPreview(dz, mockFile, thumbnailUrl || imageUrl);
        }
      );
    } else {
      finishPreview(dz, mockFile, imageUrl);
    }

    // Add hidden input like existing upload flow
    $(hiddenWrapSel).append(
      `<input type="hidden" name="${hiddenInputName}" id="slider${fileId}" value="${fileId}">`
    );

    // Add remove button like existing upload flow
    const removeButton = Dropzone.createElement(
      "<button class='btn btn-xs rmv-btn'><i class='fa fa-times'></i></button>"
    );

    removeButton.addEventListener('click', function (e) {
      e.preventDefault();
      e.stopPropagation();
      dz.removeFile(mockFile);
      rmvImg(fileId, removeEndpoint, removePayloadKey);
    });

    if (mockFile.previewElement) {
      mockFile.previewElement.appendChild(removeButton);
    }
  }


  function rmvImg(fileId, removeEndpoint, removePayloadKey) {
    const csrf = csrfToken();
    const payload = { _token: csrf };
    payload[removePayloadKey] = fileId;

    $.ajax({
      url: removeEndpoint,
      type: 'POST',
      headers: { 'X-CSRF-TOKEN': csrf },
      data: payload,
      success: function () {
        const ele = document.getElementById("slider" + fileId);
        if (ele) ele.remove();
      }
    });
  }

  // Upload a remote image URL to your existing upload endpoint 
  async function uploadRemoteToServer(uploadEndpoint, imageUrl) {
    const csrf = csrfToken();
    const resp = await $.ajax({
      url: uploadEndpoint,
      type: 'POST',
      dataType: 'json',
      headers: { 'X-CSRF-TOKEN': csrf },
      data: { _token: csrf, image_url: imageUrl } 
    });
    return resp; 
  }

  window.AiSliderDropzone = {
    active: null,

    boot: function () {
      // open modal
      $(document).on('click', '[data-ai-slider-open]', function () {
        const $btn = $(this);

        const dropzoneSel = $btn.data('dropzone') || '#my-dropzone';
        const hiddenWrapSel = $btn.data('hidden-wrap') || '#sliders';

        const dzEl = document.querySelector(dropzoneSel);
        if (!dzEl || !dzEl.dropzone) {
          console.error('Dropzone not found on selector:', dropzoneSel);
          return;
        }

        // store context
        window.AiSliderDropzone.active = {
          btn: $btn,
          dz: dzEl.dropzone,
          endpoint: $btn.data('endpoint'), 
          uploadEndpoint: $btn.data('upload-endpoint'), 
          removeEndpoint: $btn.data('remove-endpoint'), 
          removePayloadKey: $btn.data('remove-key') || 'fileid',
          hiddenInputName: $btn.data('hidden-input-name') || 'slider_images[]',
          hiddenWrapSel: hiddenWrapSel,
          maxCount: parseInt($btn.data('max-count') || '10', 10),
          styleDefault: $btn.data('style') || 'photorealistic',
          lightingDefault: $btn.data('lighting') || 'natural',
          angleDefault: $btn.data('angle') || 'eye_level',
          sizeDefault: $btn.data('size') || 'square_1024'
        };

        // set defaults
        const defCount = parseInt($btn.data('count-default') || '3', 10);
        $('#ai_slider_count').val(defCount);

        hideErr('#aiSliderErr');
        $('#ai_slider_prompt').val('');
        setIfExists('#ai_slider_style', window.AiSliderDropzone.active.styleDefault);
        setIfExists('#ai_slider_lighting', window.AiSliderDropzone.active.lightingDefault);
        setIfExists('#ai_slider_angle', window.AiSliderDropzone.active.angleDefault);
        setIfExists('#ai_slider_size', window.AiSliderDropzone.active.sizeDefault);

        $('#aiSliderModal').modal('show');
      });

      // confirm generate
      $(document).on('click', '#aiSliderConfirmBtn', async function () {
        const ctx = window.AiSliderDropzone.active;
        if (!ctx) return;

        const prompt = ($('#ai_slider_prompt').val() || '').trim();
        let count = parseInt($('#ai_slider_count').val() || '1', 10);

        if (!prompt) return showErr('#aiSliderErr', imagePrompt);
        if (isNaN(count) || count < 1) count = 1;
        if (count > ctx.maxCount) count = ctx.maxCount;

        hideErr('#aiSliderErr');

        const $btn = $(this);
        const oldHtml = $btn.html();
        $btn.prop('disabled', true).html('<i class="fas fa-spinner fa-spin mr-1"></i> ' + imageGenerating + '...');

        try {
          // 1) generate images (expects array of URLs)
          const genResp = await $.ajax({
            url: ctx.endpoint,
            type: 'POST',
            dataType: 'json',
            headers: { 'X-CSRF-TOKEN': csrfToken() },
            data: {
              _token: csrfToken(),
              prompt: prompt,
              count: count,
              style: val('#ai_slider_style'),
              lighting: val('#ai_slider_lighting'),
              angle: val('#ai_slider_angle'),
              size: val('#ai_slider_size')
            }
          });

          const ok = genResp && (genResp.status === true || genResp.success === true);
          const urls = genResp ? (genResp.images || genResp.image_urls || []) : [];

          if (!ok || !Array.isArray(urls) || urls.length === 0) {
            return showErr('#aiSliderErr', (genResp && genResp.message) ? genResp.message : 'Failed to generate images.');
          }

          // 2) For each generated URL: upload to server to get file_id
          for (let i = 0; i < urls.length; i++) {
            const imageUrl = urls[i];
            const up = await uploadRemoteToServer(ctx.uploadEndpoint, imageUrl);

            const fileId = up && (up.file_id || up.id || up.uniqueName);
            const previewUrl = up && (up.preview_url || up.url || imageUrl);

            if (!fileId) continue;

            addUrlToDropzone(
              ctx.dz,
              previewUrl,
              fileId,
              ctx.hiddenWrapSel,
              ctx.hiddenInputName,
              ctx.removeEndpoint,
              ctx.removePayloadKey
            );
          }

          $('#aiSliderModal').modal('hide');
        } catch (e) {
          console.error('AI Slider error:', e);
          showErr('#aiSliderErr', 'Network error. Please try again.');
        } finally {
          $btn.prop('disabled', false).html(oldHtml);
        }
      });
    }
  };

  $(function () {
    window.AiSliderDropzone.boot();
  });

})(window, window.jQuery);
