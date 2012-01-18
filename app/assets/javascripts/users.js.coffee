# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

#add the error class to any tag
#already in the alert class since devise 'uses' alert and web-app-theme uses 'error'
  
$ = jQuery
$ ->
  $('.alert').addClass 'error'
  $('.flash').delay(2000).slideUp()
