# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
  console.log("ready");
  $("form").bind "ajax:success", (evt, data, status, xhr) ->
    AddRow.verify(data)
  $("form").bind "ajax:error", (xhr, status, error) ->
    alert(error)
  $(".choose").bind "click", ()->
    return SelectHeader.choose(this)

$(document).ready(ready);
$(document).on('page:load', ready);