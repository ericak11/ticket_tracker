$(document).ready(function() {
  $('#mass_add_tgs').on('click', function(e){
    e.stopPropagation();
    e.preventDefault();
  });

  $('#datetimepicker3').datetimepicker({
      format: 'LT',
      stepping: 15
  });
})
