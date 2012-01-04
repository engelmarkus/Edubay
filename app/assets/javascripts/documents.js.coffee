# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready( ->
  $('.delete_document').live('ajax:success', ->
    $(this).closest('tr').fadeOut();
  );
);


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

$(document).ready( ->
  $('form').live('ajax:aborted:file', ->
    # Das würde einen normalen AJAX-Call machen, aber er lässt dabei einfach
    # das Datei-Feld bei der Übertragung raus.
    # $.post($(this).attr("action")+'.js', $(this).serialize(), null, "script");
    
    # Deswegen benutzen wir HTML5, mit einem XMLHttpRequest Level 2 gehts
    # nämlich trotzdem.
    
    fd = new FormData($(this)[0]);
    
    xhr = new XMLHttpRequest();
    xhr.upload.addEventListener("progress", uploadProgress, false);
    xhr.addEventListener("load", uploadComplete, false);
    xhr.addEventListener("error", uploadFailed, false);
    xhr.addEventListener("abort", uploadCanceled, false);
    
    xhr.open("POST", "/documents.js");
    xhr.send(fd);
    
    $('#commit').attr("disabled", true);
    
    # Das Formular nicht normal posten.
    return false;
  );

  uploadProgress = (event) ->
    if event.lengthComputable
      percent = Math.round(event.loaded * 100 / event.total);
      $('#percentCompleted').html("Percent completed: #{percent} %");
    else
      $('#percentCompleted').html("Percent completed: unable to compute");

  uploadFailed = (event) ->
    window.alert("There was an error attempting to upload the file.");
    $('#commit').attr("disabled", false);

  uploadCanceled = (event) ->
    window.alert("The upload has been canceled by the user or the browser dropped the connection.");
    $('#commit').attr("disabled", false);

  uploadComplete = (event) ->
    $('#percentCompleted').html("Upload complete...");
    window.location = event.target.response;

  # Größe der hochzuladenden Datei bei Änderung berechnen und im span "fileSize" ausgeben.
  $('#fileToUpload').on('change', ->
    file = $(this)[0].files[0];
    
    if file
      fileSize = 0;
      
      if file.size > 1024 * 1024
        fileSize = (Math.round(file.size * 100 / (1024 * 1024)) / 100).toString() + ' MB';
      else
        fileSize = (Math.round(file.size * 100 / 1024) / 100).toString() + ' KB';
      
      $('#fileSize').html("Size: #{fileSize}");
  );
);

