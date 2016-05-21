# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
addBlankTable = () ->
  return "<td></td>"

addEvent = (data) ->
  td = "<td colspan='" + data.duration + "' class='event'>"
  td += "<b>" + data.event.title + "</b>"
  td += "<hr>"
  td += data.event.description

display_error = (key, messages)->
  alert(key + ": " + message) for new_key, message of messages

display_errors = (data)->
  console.log(data)
  display_error(key, messages) for key, messages of data.errors

create_table = (data)->
  row = "<tr>"
  row += addBlankTable() for i in [1..data.from] unless data.from == 0
  row += addEvent(data)
  remaining = 7 - data.duration - data.from
  row += addBlankTable() for i in [1..remaining] unless remaining == 0
  $("tbody").append(row)

verify = (data)->
  console.log(data)
  if data.status == 1
    if data.duration == 0
      alert("This event does not happen this week")
    else
      create_table data
  else
    display_errors data

chosen_date = null
from_wday = null
to_wday = null

choose_from = (date, wday) ->
  $(".choose").removeClass("selected")
  $("#choose_" + wday).addClass("selected")
  from_wday = wday
  chosen_date = date
  console.log(date)
  $("#event_start").val(date)
  $("#event_finish").val(null)

choose_to = (date, wday) ->
  $(".choose").removeClass("selected")
  to_wday = wday
  $("#choose_" + day).addClass("selected") for day in [from_wday..to_wday]
  $("#event_finish").val(date)
  chosen_date = null

choose = (element)->
  date = $(element).data("date")
  wday = $(element).data("wday")
  if(chosen_date == null)
    choose_from(date, wday)
  else
    choose_to(date, wday)

ready = ->
  console.log("ready");
  $("form").bind "ajax:success", (evt, data, status, xhr) ->
    verify(data)
  $("form").bind "ajax:error", (xhr, status, error) ->
    notify(error)
  $(".choose").bind "click", (evt)->
    return choose(evt.toElement)

$(document).ready(ready);
$(document).on('page:load', ready);