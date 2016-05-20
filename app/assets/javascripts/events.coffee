# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
addBlankTable = () ->
  return "<td></td>"
addEvent = (data) ->
  td="<td colspan='"+data.duration+"'>"
  td+=(data.event.title)
  td+="<hr>"
  td+=data.event.description
create_table = (data)->
  row="<tr>"
  row+=addBlankTable() for i in [1..data.from] unless data.from==0
  row+=addEvent(data)
  remaining=7-data.duration-data.from
  row+=addBlankTable() for i in [1..remaining] unless remaining==0

  $("table  > tbody:last-child")  .append(row)
verify = (data)->
  console.log(data)
  if data.status == 1
    if data.duration==0
      alert("This event does not happen this week")
    else
      create_table data
  else
    display_errors data
ready = ->
  console.log("ready");
  $("form").bind "ajax:success", (evt, data, status, xhr) ->
    verify(data)
  $("form").bind "ajax:error", (xhr, status, error) ->
    notify(error)

$(document).ready(ready);
$(document).on('page:load', ready);