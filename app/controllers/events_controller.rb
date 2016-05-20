class EventsController < ApplicationController
  def index
    @today = Time.now.day

    beginning_of_week = Time.now.beginning_of_week
    @days = (0..6).to_a.collect { |past| beginning_of_week+past.days }
    end_of_week = @days.last + 1.days #Technically beginning of next week
    @events = Event.where("(start > ? AND start < ?) OR (finish > ? AND finish < ?)", beginning_of_week, end_of_week, beginning_of_week, end_of_week)
  end

  def create
    @event=Event.new(event_params)
    if (@event.save) then
      render json: {
          status: 1,
          event: @event
      }
    else
      render json: {
          status: -1,
          errors: @event.errors
      }
    end
  end

  def event_params
    params.require(:event).permit(:start, :finish, :title, :description)
  end
end
