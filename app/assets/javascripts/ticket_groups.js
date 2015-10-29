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
 $("#_past_events").change(function() {
    if(this.checked) {
      $("#_listed_tickets").attr("disabled", true);
      $("#_unlisted_tickets").attr("disabled", true);
      $("#_future_events").attr("disabled", true);
    } else {
      $("#_listed_tickets").removeAttr("disabled");
      $("#_unlisted_tickets").removeAttr("disabled");
      $("#_future_events").removeAttr("disabled");
    }
  });
  $("#_future_events").change(function() {
    if(this.checked) {
      $("#_unused").attr("disabled", true);
    } else {
      $("#_unused").removeAttr("disabled");
    }
  });
})
