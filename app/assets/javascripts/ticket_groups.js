$(document).ready(function() {
  $('#mass_add_tgs').on('click', function(e){
    e.stopPropagation();
    e.preventDefault();
  });

  $('#datetimepicker3').datetimepicker({
    format: 'LT',
    stepping: 15
  });
  $('.datetimepicker4').datetimepicker({
    format: 'YYYY-MM-DD'
  });
 $("#_filter_past_events").change(function() {
    if(this.checked) {
      $("#_filter_listed_tickets").attr("disabled", true);
      $("#_filter_unlisted_tickets").attr("disabled", true);
      $("#_filter_future_events").attr("disabled", true);
    } else {
      $("#_filter_listed_tickets").removeAttr("disabled");
      $("#_filter_unlisted_tickets").removeAttr("disabled");
      $("#_filter_future_events").removeAttr("disabled");
    }
  });
  $("#_filter_future_events").change(function() {
    if(this.checked) {
      $("#_filter_unused").attr("disabled", true);
      $("#_filter_past_events").attr("disabled", true);
    } else {
      $("#_filter_unused").removeAttr("disabled");
      $("#_filter_past_events").attr("disabled", true);
    }
  });
})
