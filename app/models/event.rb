class Event < ActiveRecord::Base
  def beginning_wday (beginning_of_week)
    [[0, date_difference(beginning_of_week)].max, 6].min
  end

  def duration_days (beginning_of_week)
    wday=date_difference(beginning_of_week)
    [[7-wday, duration, duration+wday, 7].min, 0].max
  end

  def duration
    (finish.to_date - start.to_date).to_i + 1
  end


  def date_difference (beginning_of_week)
    date_difference = (start.to_date - beginning_of_week.to_date).to_i
  end


end
