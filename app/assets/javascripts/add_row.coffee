window.AddRow = {};

AddRow.verify = (data)->

  $(".field").removeClass("has-error")
  if data.status == 1
    if data.duration == 0
      alert("This event does not happen this week")
    else
      create_table data
  else
    display_errors data

addBlankRow = () ->
  row = "<tr>"
  row += addBlankColumn() for i in [1..7]
  row += "</tr>"
  return row

addBlankColumn = () ->
  return "<td>&nbsp;</td>"

addEvent = (data) ->
  td = "<td colspan='" + data.duration + "' class='event'>"
  td += "<b>" + data.event.title + "</b>"
  td += "<br>"
  td += data.event.description

display_error = (key, messages)->
  $("#event_"+key).parent().addClass("has-error")
  $(".errors-container").append("<div class='alert alert-danger fade in'>
    <button class='close' data-dismiss='alert'>×</button>
    "+key+": "+message+"
    </div>"
  ) for new_key, message of messages

display_errors = (data)->
  $(".errors-container").text("")
  display_error(key, messages) for key, messages of data.errors

create_table = (data)->
  row = addBlankRow()
  row += "<tr>"
  row += addBlankColumn() for i in [1..data.from] unless data.from == 0
  row += addEvent(data)
  remaining = 7 - data.duration - data.from
  row += addBlankColumn() for i in [1..remaining] unless remaining == 0
  row += "</tr>"
  row += addBlankRow()
  $("tbody").append(row)


chosen_date = null
from_wday = null
to_wday = null