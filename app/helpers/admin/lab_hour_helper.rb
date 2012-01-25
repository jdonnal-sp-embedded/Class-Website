module Admin::LabHourHelper
  
  def printLabHour(hour)
    strStart=hour.start_at.in_time_zone.strftime('%a %H:%M')
    strEnd=hour.end_at.in_time_zone.strftime('%H:%M')
    "#{strStart} &mdash; #{strEnd} (#{hour.user.username})".html_safe
  end
end
