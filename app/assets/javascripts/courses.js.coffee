# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready( ->
  # Make index table sortable
  $('#courses_index').tablesorter(
    sortList: [[0, 1], [1, 0]],
    headers:
      4:
        sorter: false
      5:
        sorter: false
  )
  
  # Make documents table in course detail view sortable
  $('#course_documents').tablesorter(
    sortList: [[0, 1]],
    headers:
      1:
        sorter: false
  )

  # Validation rules for submit form
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