# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ = jQuery


show_users = ->
  $('#users_tab').parent().addClass 'active'
  $('#events_tab').parent().removeClass 'active'
  $('#events_block').hide()
  $('#users_block').fadeIn()
  
show_events = ->
  $('#events_tab').parent().addClass 'active'
  $('#users_tab').parent().removeClass 'active'
  $('#events_block').fadeIn()
  $('#users_block').hide()

show_introduction = ->
  $('#events_tab').parent().removeClass 'active'
  $('#users_tab').parent().removeClass 'active'
  $('#events_block').hide()
  $('#users_block').hide()
  
$ ->
   $('#users_tab').click -> show_users()
   $('#events_tab').click -> show_events()
   $('#users_block').hide()
   $('.flash').delay(2000).slideUp()
   $('a[rel*=facebox]').facebox {
      loadingImage : '/assets/facebox/loading.gif'
      closeImage   : '/assets/facebox/closelabel.png'}
