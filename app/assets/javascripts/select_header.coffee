window.SelectHeader = {};
SelectHeader.choose = (element)->
  date = $(element).data("date")
  wday = $(element).data("wday")
  if(chosen_date == null)
    choose_from(date, wday)
  else
    choose_to(date, wday)
  return false

chosen_date = null
from_wday = null
to_wday = null

choose_from = (date, wday) ->
  $(".choose").removeClass("selected")
  $("#choose_" + wday).addClass("selected")
  from_wday = wday
  chosen_date = date
  $("#event_start").val(date)
  $("#event_finish").val(null)

choose_to = (date, wday) ->
  $(".choose").removeClass("selected")
  to_wday = wday
  $("#choose_" + day).addClass("selected") for day in [from_wday..to_wday]
  $("#event_finish").val(date)
  chosen_date = null


