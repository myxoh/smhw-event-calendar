class Event < ActiveRecord::Base
  def beginning_wday (beginning_of_week)
    date_difference = (start.to_date - beginning_of_week.to_date).to_i
    [0, date_difference].max
  end

  def duration_days (beginning_of_week)
    wday=beginning_wday(beginning_of_week)
    [7-wday, wday + duration + 1].min
  end

  def duration
    (finish.to_date - start.to_date).to_i
  end


end
