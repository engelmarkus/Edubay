# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# Validation rules for submit form
$(document).ready( ->
  $("#new_course").validate(
    rules:
      "course[name]":
        required: true
      "course[abbreviation]":
        required: true
      "course[lecturer_id]":
        required: true
  );
);