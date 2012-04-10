# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# Add a parser for names; needed for sorting by last name
$.tablesorter.addParser(
  id: 'lastnames'
  is: (s) ->
    false
  format: (s) ->
    s = s.split(" ")
    
    return s[s.length - 1]
  type: 'text'
)

$(document).ready( ->
  # Make index table sortable
  $('#lecturers_index').tablesorter(
    sortList: [[0, 0]],
    headers:
      0:
        sorter: 'lastnames'
      1:
        sorter: false
      2:
        sorter: false
  );
  
  # Make courses table in lecturer detail view sortable
  $('#lecturer_courses').tablesorter(
    sortList: [[0, 1], [1, 0]],
    headers:
      0:
        sorter: 'terms'
  );

  # Validation rules for submit form
  $("#new_lecturer").validate(
    rules:
      "lecturer[name]":
        required: true
  );
);
