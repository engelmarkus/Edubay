# Funktionen, die seitenweit verwendet werden.
Site.common ||= {}

Site.common.init = ->
  Site.common.setupTablesorter()
  Site.common.setupDialogs()
  Site.common.createJQueryButtons()

# Standardoptionen für den Tablesorter setzen
Site.common.setupTablesorter = ->
  $.tablesorter.defaults.sortList = [[0, 0]]

# Standardoptionen für alle Dialoge setzen
Site.common.setupDialogs = ->
  $.extend($.ui.dialog.prototype.options, {
    draggable: false
    resizable: false
    width: "auto"
    height: "auto"
    modal: true
    show: "scale"
    hide: "scale"
  })

# Links in JQuery-Buttons umwandeln
Site.common.createJQueryButtons = ->
  $(".show_button").button(
    icons:
      primary: "ui-icon-document"
    text: false
  )
  
  $(".edit_button").button(
    icons:
      primary: "ui-icon-pencil"
    text: false
  )
  
  $(".delete_button").button(
    icons:
      primary: "ui-icon-trash"
    text: false
  )
