module EventsHelper
  def weekday day
    return day.strftime("%A")
  end
  def formatted day
    return day.strftime("%d %b")
  end
  def simple day
    day.strftime("%Y-%m-%d")
  end
  def wday day
    (day.wday + 6) % 7 #Returns wday where Monday = 0 and not Sunday = 0
  end
end
