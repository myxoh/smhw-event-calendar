class Event < ActiveRecord::Base
  validates_presence_of :start, :finish, :title, :description
  validates :title, length: {in: 2..15}
  validates :description, length: {in: 2..100}
  before_save :check_order_start_finish

  def beginning_wday (beginning_of_week)
    [[0, days_from_beginning_of_week(beginning_of_week)].max, 6].min
  end

  def duration_days (beginning_of_week) #Duration during this week (So no more than 7)
    wday = days_from_beginning_of_week(beginning_of_week)
    [[7-wday, duration, duration+wday, 7].min, 0].max
  end

  def duration
    (finish.to_date - start.to_date).to_i + 1
  end

  private
  def check_order_start_finish #Assume mistake if from and to is in wrong order
    if (start > finish) then
      new_start = finish
      self.finish = start
      self.start = new_start
    end
  end

  def days_from_beginning_of_week (beginning_of_week)
    date_difference = (start.to_date - beginning_of_week.to_date).to_i
  end


end
