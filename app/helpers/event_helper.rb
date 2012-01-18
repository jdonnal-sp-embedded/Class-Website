module EventHelper
  def printTime(event)
     #determine if the event happens in a single day
    oneDay=false
    oneDay= true if event.start_at.in_time_zone.month==event.end_at.in_time_zone.month && event.start_at.in_time_zone.day==event.end_at.in_time_zone.day
    #format for all day events
    if(event.all_day?)
      t_start=event.start_at.in_time_zone.strftime("%b %d")
      t_end=event.end_at.in_time_zone.strftime("%b %d")
      return t_start if(oneDay)
      return (t_start+" &mdash; "+t_end)
    #format for timed events
    else
      if(oneDay)
        t_date=event.start_at.in_time_zone.strftime("%b %d")
        t_start=event.start_at.in_time_zone.strftime("%I:%M")
        t_end=event.end_at.in_time_zone.strftime("%I:%M")
        return (t_date+" "+t_start+" &mdash; "+t_end)
      else
        t_start=event.start_at.in_time_zone.strftime("%b %d %I:%M")
        t_end=event.end_at.in_time_zone.strftime("%b %d %I:%M")
        return (t_start+" &mdash; "+t_end)
      end
    end
  end
  
  def printSlotTime(slot)
    return slot.start_at.in_time_zone.strftime("%H:%M")
  end
  
  def printSlotStudent(slot)
    return "&mdash;".htmlSafe if slot.student ==nil
    return slot.student.username
  end
end
