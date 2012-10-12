# Garber-Irish-Methode.
# Ermöglicht die Aufteilung von Javascript, sodass immer nur der Teil ausgeführt wird, der
# zur gerade angezeigten Seite gehört.
# Aufteilung:
#   Site.common.init() - wird immer ausgeführt.
#   Site.controller.init() - wird in jeder Seite, die zu controller gehört, ausgeführt.
#   Site.controller.action() - wird nur in der Seite ausgeführt, die zum controller und zur action gehört.
# Die Funktionen werden in dieser Reihenfolge aufgerufen.

# Leeres, globales Site-Objekt.
window.Site ||= {}

Util = {
  exec: (controller, action = "init") ->
    window.Site[controller]?[action]?()
  
  init: ->
    body = document.body
    controller = body.getAttribute("data-controller")
    action = body.getAttribute("data-action")
    
    Util.exec("common")
    Util.exec(controller)
    Util.exec(controller, action)
}

$(document).ready(Util.init)


#########################
# Erzeugt einen Dalog aus einem div, der sich sofort öffnet und nur einen OK-Button hat.
# Die Buttons kann man überschreiben.
# Blendet den Container vorher selbständig aus und entfernt ihn nach dem Schließen wieder.
# $(divobjekt).createDialog()
$.fn.createDialog = (buttons = "OK": -> $(this).dialog("close")) ->
  $(this).css("display", "none").appendTo("body").dialog(
    buttons: buttons,
    close: -> $(this).remove()
  )
#########################