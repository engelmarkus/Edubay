// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require jquery-tablesorter
//= require_tree .

// Liest alle/eine der in der URL übergebenen Variablen aus und packt sie in ein(e) Array/Variable.
// z. B.: var alle = $.getUrlVars();
// z. B.: var name = $.getUrlVar('name');
$.extend({
  getUrlVars: function() {
    var vars = [], hash;
    var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');

    for(var i = 0; i < hashes.length; i++) {
      hash = hashes[i].split('=');
      vars.push(hash[0]);
      vars[hash[0]] = hash[1];
    }
    
    return vars;
  },
  
  getUrlVar: function(name) {
    return $.getUrlVars()[name];
  }
});

// Blendet beim Klick auf den Löschen-Button neben einem Datensatz die jeweilige Zeile aus.
// Falls der Server einen Fehler meldet, wird stattdessen dieser angezeigt.
$(document).ready(function() {
  $(document).on("ajax:success", ".delete_button", function() {
    $(this).closest('tr').fadeOut();
  });
  
  $(document).on("ajax:error", ".delete_button", function(e0, e1) {
    alert(e1.responseText);
  });
});
