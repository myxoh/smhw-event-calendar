module EventsHelper
  def weekday day
    return day.strftime("%A")
  end
  def formatted day
    return day.strftime("%d %b")
  end
end
