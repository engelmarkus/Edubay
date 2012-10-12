# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
Site.courses ||= {}

Site.courses.index = ->
  $("#courses_table").tablesorter()
  
  $("#new_course_button").button(
    icons:
      primary: "ui-icon-plusthick"
  )
  
  # Event Handler für die Index-Seite hinzufügen.
  # Neue Veranstaltung.
  # Antwort: Dialog-Div mit Formular
  $("#new_course_button").on("ajax:success", (xhr, data, status) ->
    dialogDiv = $(data)
    dialogDiv.createDialog(
      "Veranstaltung hinzufügen": -> $("#new_course").submit()
      "Abbrechen": -> $(this).dialog("close")
    )
    
    # Speichern erfolgreich.
    # Antwort: einzufügende Tabellenzeile
    $("#new_course").on("ajax:success", (xhr, data, status) ->
      dialogDiv.dialog("close")
      
      zeile = $(data)
      
      # Zeile unsichtbar anfügen
      zeile.css("display", "none").appendTo("#courses_table tbody")

      # Aktions-Links in Buttons umwandeln      
      Site.common.createJQueryButtons()
      
      # Neu sortieren lassen, sodass sie an der richtigen Stelle eingeblendet wird
      $("#courses_table").trigger("update")
      
      # Einblenden
      zeile.fadeIn()
    )
    
    # Speichern fehlgeschlagen.
    # Antwort: Dialog-Div mit Fehlermeldung
    $("#new_course").on("ajax:error", (event, xhr, status) ->
      $(xhr.responseText).createDialog()
    )
  )
  
  # Veranstaltung bearbeiten.
  # Antwort: Dialog-Div mit Formular
  $(document).on("ajax:success", ".edit_button", (xhr, data, status) ->
    dialogDiv = $(data)
    dialogDiv.createDialog(
      "Veranstaltung aktualisieren": -> $(".edit_course").submit()
      "Abbrechen": -> $(this).dialog("close")
    )
    
    # Aktualisieren erfolgreich.
    # Antwort: aktualisierte Tabellenzeile
    $(".edit_course").on("ajax:success", (xhr, data, status) =>  # !!
      dialogDiv.dialog("close")
      
      # Zeilen ermitteln
      neueZeile = $(data)
      alteZeile = $(this).closest("tr")
      
      # Neue Zeile unsichtbar einfügen und Links umwandeln 
      neueZeile.css("display", "none").insertAfter(alteZeile)
      Site.common.createJQueryButtons()

      # Zeilen überblenden      
      alteZeile.fadeOut( ->
        neueZeile.fadeIn()
      )
    )
    
    # Aktualisieren fehlgeschlagen.
    # Antwort: Dialog-Div mit Fehlermeldung
    $(".edit_course").on("ajax:error", (event, xhr, status) ->
      $(xhr.responseText).createDialog()
    )
  )
