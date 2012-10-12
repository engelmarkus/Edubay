# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
Site.documents ||= {}

Site.documents.index = ->
  $("#documents_table").tablesorter()
  
  $("#new_document_button").button(
    icons:
      primary: "ui-icon-plusthick"
  )

Site.documents.new = ->
  # * Uploading file using rails.js
  # * =============================
  # *
  # * By default, browsers do not allow files to be uploaded via AJAX. As a result, if there are any non-blank file fields
  # * in the remote form, this adapter aborts the AJAX submission and allows the form to submit through standard means.
  # *
  # * The `ajax:aborted:file` event allows you to bind your own handler to process the form submission however you wish.
  # *
  # * Ex:
  # *     $('form').live('ajax:aborted:file', function(event, elements){
  # *       // Implement own remote file-transfer handler here for non-blank file inputs passed in `elements`.
  # *       // Returning false in this handler tells rails.js to disallow standard form submission
  # *       return false;
  # *     });
  # *
  # * The `ajax:aborted:file` event is fired when a file-type input is detected with a non-blank value.
  # *
  # * Third-party tools can use this hook to detect when an AJAX file upload is attempted, and then use
  # * techniques like the iframe method to upload the file instead.
  $('form').on('ajax:aborted:file', ->
    # Das würde einen normalen AJAX-Call machen, aber er lässt dabei einfach
    # das Datei-Feld bei der Übertragung raus.
    # $.post($(this).attr("action")+'.js', $(this).serialize(), null, "script");
    
    fd = new FormData($(this)[0]);
    
    xhr = new XMLHttpRequest();
    xhr.upload.addEventListener("progress", uploadProgress, false);
    xhr.addEventListener("load", uploadComplete, false);
    xhr.addEventListener("error", uploadFailed, false);
    xhr.addEventListener("abort", uploadCanceled, false);
    
    xhr.open("POST", $(this)[0].action);
    xhr.send(fd);
    
    $('#dialog').dialog({
      draggable: false,
      modal: true,
      resizable: false,
      buttons: [{
        text: "Abbrechen",
        click: -> $(this).dialog("close");
      }],
      close: -> xhr.abort();
    });
    
    # Das Formular nicht normal posten.
    return false;
  );
  
  uploadProgress = (event) ->
    if event.lengthComputable
      percent = Math.round(event.loaded * 100 / event.total);
      $('#percentCompleted').html("#{percent} %");
      $('#progressbar').progressbar({ value: percent });
    else
      $('#percentCompleted').html("unable to compute");
  
  uploadFailed = (event) ->
    window.alert("There was an error attempting to upload the file.");
  
  uploadCanceled = (event) ->
    window.alert("The upload has been canceled by the user or the browser dropped the connection.");
  
  uploadComplete = (event) ->
    $('#percentCompleted').html("Upload complete...");
    window.location = event.target.response;
