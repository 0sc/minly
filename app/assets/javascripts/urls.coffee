# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  $('a#copy').zclip
    path: 'ZeroClipboard.swf'
    copy: ->
      $('#new_shortened_url').text()
    afterCopy: ->
      alert 'link copied!'
      return
  return
