# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  $(".create-submit").click ->
    $("#form-ajax-loader").fadeIn("slow")
    return
  $("#button-to-create-minly").click ->
    $(".toggle-display").toggle("slow")
    x = $(this).text()
    x = if x == 'Create minly' then 'close' else 'Create minly'
    $(this).text(x)
    return
  return
