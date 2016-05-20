class EventsController < ApplicationController
  def index
    @today = Time.now.day

    beginning_of_week = Time.now.beginning_of_week
    @days = (0..6).to_a.collect do |past|
      day = (beginning_of_week+past.days)
      weekday = day.strftime("%A") #Will return day of the week
      formated = day.strftime("%A") #TODO format here.
      {
          day: day,
          weekday: weekday,
          formated: formated
      }
    end
  end
end
