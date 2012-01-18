# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

#Tab Navigator Functions
$ = jQuery

show_info = ->
  $('#info_tab').parent().addClass 'active'
  $('#objectives_tab').parent().removeClass 'active'
  $('#introduction_tab').parent().removeClass 'active'
  $('#objectives_block').hide()
  $('#info_block').fadeIn()
  $('#introduction_block').hide()
  
show_objectives = ->
  $('#objectives_tab').parent().addClass 'active'
  $('#info_tab').parent().removeClass 'active'
  $('#introduction_tab').parent().removeClass 'active'
  $('#objectives_block').fadeIn()
  $('#info_block').hide()
  $('#introduction_block').hide()

show_introduction = ->
  $('#introduction_tab').parent().addClass 'active'
  $('#objectives_tab').parent().removeClass 'active'
  $('#info_tab').parent().removeClass 'active'
  $('#objectives_block').hide()
  $('#info_block').hide()
  $('#introduction_block').fadeIn()
  
$ ->
   $('#info_tab').click -> show_info()
   $('#objectives_tab').click -> show_objectives()
   $('#introduction_tab').click -> show_introduction()
   $('#objectives_block').hide()
   $('#info_block').hide()
   $('.flash').delay(2000).slideUp()
   
