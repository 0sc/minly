# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "page:change", ->
  $(".url-listing div p:first").addClass("active")
  $(".url-listing").on "click", "div p", ->
    $("p").removeClass("active")
    $(this).addClass("active")
    $('#edit_form').addClass 'add-ajax-loader'
    link = "/urls/" + ($(this).attr("id").replace("url_", ""))
    $("#trigger a").attr("href", link)
    $("#trigger a").trigger("click")
