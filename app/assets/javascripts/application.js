// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require_tree .

//$(document).ajaxComplete(function(event, request) {
//  var msg = request.getResponseHeader('X-Message');
//  var type = request.getResponseHeader('X-Message-Type');
  
//  if (!msg) {
//    return;
//  }
  
  //if (type == 'notice') {
  //  $('notice').html(flash.notice);
  //}
  
  //if (type == 'error') {
//    alert(msg);
  //}
//});

// Liest die in der URL übergebenen Variablen aus und packt sie in ein Array.
// z. B.: var alle = $.getUrlVars();
// z. B.: var name = $.getUrlVar('name');
$.extend({
  getUrlVars: function(){
    var vars = [], hash;
    var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
    for(var i = 0; i < hashes.length; i++)
    {
      hash = hashes[i].split('=');
      vars.push(hash[0]);
      vars[hash[0]] = hash[1];
    }
    return vars;
  },
  
  getUrlVar: function(name){
    return $.getUrlVars()[name];
  }
});
