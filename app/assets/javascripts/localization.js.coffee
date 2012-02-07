# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# Einige Elemente, insbesondere jQuery-Steuerelemente, können erst zur Laufzeit auf
# auf dem Client lokalisiert werden.

# Setzt je nach locale der Seite die Sprache des jQuery DatePickers bzw. des TimePickers.
$(window).load( ->
  if $.getUrlVar('locale') == 'en'
    $.datepicker.setDefaults($.datepicker.regional['en']);
    $.timepicker.setDefaults($.timepicker.regional['en']);
  else
    $.datepicker.setDefaults($.datepicker.regional['de']);
    $.timepicker.setDefaults($.timepicker.regional['de']);
    
    jQuery.extend(jQuery.validator.messages, {
	    required: "Dieses Feld ist ein Pflichtfeld.",
	    maxlength: jQuery.validator.format("Geben Sie bitte maximal {0} Zeichen ein."),
	    minlength: jQuery.validator.format("Geben Sie bitte mindestens {0} Zeichen ein."),
	    rangelength: jQuery.validator.format("Geben Sie bitte mindestens {0} und maximal {1} Zeichen ein."),
	    email: "Geben Sie bitte eine gültige E-Mail Adresse ein.",
	    url: "Geben Sie bitte eine gültige URL ein.",
	    date: "Bitte geben Sie ein gültiges Datum ein.",
	    number: "Geben Sie bitte eine Nummer ein.",
	    digits: "Geben Sie bitte nur Ziffern ein.",
	    equalTo: "Bitte denselben Wert wiederholen.",
	    range: jQuery.validator.format("Geben Sie bitten einen Wert zwischen {0} und {1}."),
	    max: jQuery.validator.format("Geben Sie bitte einen Wert kleiner oder gleich {0} ein."),
	    min: jQuery.validator.format("Geben Sie bitte einen Wert größer oder gleich {0} ein."),
	    creditcard: "Geben Sie bitte ein gültige Kreditkarten-Nummer ein."
    });
    
    jQuery.extend(jQuery.validator.methods, {
	    date: (value, element) ->
		    return this.optional(element) || /^\d\d?\.\d\d?\.\d\d\d?\d?$/.test(value);
	    
      number: (value, element) ->
		    return this.optional(element) || /^-?(?:\d+|\d{1,3}(?:\.\d{3})+)(?:,\d+)?$/.test(value);
    });
);