"use strict";
function updateHoliday(holidayId, holidayValue) {

  $.ajax({
    url: storeHoliday,
    type: "POST",
    data: {
      'holidayId': holidayId,
      'holiday': holidayValue,
    },
    success: function (response) {
     
      location.reload();
    },
    error: function (xhr, status, error) {

    }
  });
}

$('.in_start_time').daterangepicker({
  opens: 'left',
  timePicker: true,
  "singleDatePicker": true,
  timePickerIncrement: 1,
  timePicker24Hour: timePicker,
  locale: {
    format: timeFormate
  }
}).on('show.daterangepicker', function (ev, picker) {
  picker.container.find(".calendar-table").hide();
})

$('.in_start_time').on('apply.daterangepicker', function (ev, picker) {
  $(this).val(picker.startDate.format(timeFormate));
});

$('.in_start_time').on('cancel.daterangepicker', function (ev, picker) {
  $(this).val('');
});
