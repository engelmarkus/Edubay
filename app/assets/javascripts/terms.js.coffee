# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# Add a parser for term names; needed for correct sorting
# "SS 2011" - "WS 2011 / 2012" - "SS 2012" - ...
$.tablesorter.addParser(
  id: 'terms'
  is: (s) ->
    false
  format: (s) ->
    [season, year] = s.split(" ")
    
    return year + season
  type: 'text'
)

$(document).ready( ->
  # Make index table sortable
  $('#terms_index').tablesorter(
    sortList: [[0, 1]],
    headers:
      0:
        sorter: 'terms'
      1:
        sorter: false
      2:
        sorter: false
  )

  # Validation rules for submit form
  $("#new_term").validate(
    rules:
      "term[name]":
        required: true
  )
)