Site.courses ||= {}

Site.courses.index = ->
  $("#courses_table").tablesorter(sortList: [[0, 0]])
