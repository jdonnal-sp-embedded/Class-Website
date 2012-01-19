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
      return (t_start+" &mdash; "+t_end).html_safe
    #format for timed events
    else
      if(oneDay)
        t_date=event.start_at.in_time_zone.strftime("%b %d")
        t_start=event.start_at.in_time_zone.strftime("%H:%M")
        t_end=event.end_at.in_time_zone.strftime("%H:%M")
        return (t_date+" "+t_start+" &mdash; "+t_end).html_safe
      else
        t_start=event.start_at.in_time_zone.strftime("%b %d %H:%M")
        t_end=event.end_at.in_time_zone.strftime("%b %d %H:%M")
        return (t_start+" &mdash; "+t_end).html_safe
      end
    end
  end
  
  def printSlotTime(slot)
    return slot.start_at.in_time_zone.strftime("%H:%M").html_safe
  end
  
  def printSlotAttendee(slot)
    return "&mdash;".html_safe if slot.attendee ==nil
    return slot.attendee.username
  end
  
  def uniqueSignUpSlots(event)
    #find all the unique start times and put them in an array
    unique_slots=[]
    event.slots.available.asc(:start_at).each do |slot|
      if unique_slots.last == nil
        unique_slots<<slot
      else
        next if slot.start_at==unique_slots.last.start_at #not unique so skip
        unique_slots<<slot
      end
    end
    return unique_slots
  end
end
