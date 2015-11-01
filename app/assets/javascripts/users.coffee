# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "page:change", ->
  $(".url-listing p:first").addClass("active")
  $(".url-listing p").click ->
    $("p").removeClass("active")
    $(this).addClass("active")
    link = "/urls/" + ($(this).attr("id").replace("url_", ""))
    $("#trigger a").attr("href", link)
    $("#trigger a").trigger("click")
