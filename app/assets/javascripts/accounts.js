$(document).ready(function() {
  var thisMonth     = new Date().getMonth();
  var selectedMonth = window.location.href.split('/').pop();
  var defaultDate   = selectedMonth ? (selectedMonth - thisMonth - 1) + 'm' : null;

  $('#date').datepicker({
    onChangeMonthYear: function(year, month, instance) {
      window.location.href = $(this).closest('form').attr('action') + '/' + month;
    },
    showOn:      'button',
    buttonText:  'Select month',
    defaultDate: defaultDate,
    dateFormat:  'm'
  });
});
