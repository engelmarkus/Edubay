# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready( ->
  $('#reservation_time_from').timepicker();
  $('#reservation_time_to').timepicker();
);

# Validation rules for submit form
$(document).ready( ->
  $("#new_reservation").validate(
    rules:
      "reservation[time_from]":
        required: true
      "reservation[time_to]":
        required: true
      "reservation[device_id]":
        required: true
  );
);