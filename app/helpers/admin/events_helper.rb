module Admin::EventsHelper
  def printTime(event)
    t_start=""
    t_end=""
    if(event.all_day?)
      t_start=event.start_at.in_time_zone.strftime("%b %d")
      t_end=event.end_at.in_time_zone.strftime("%b %d")
    else
      t_start=event.start_at.in_time_zone.strftime("%b %d %H:%M")
      t_end=event.end_at.in_time_zone.strftime("%b %d %H:%M")
    end
    (t_start+" &mdash; "+t_end).html_safe
  end
  
  def printSlots(event)
    if(event.slotable?)
      if event.slots.count==0
        return 'no slots'
      else
        return event.slots.available.count.to_s+' of '+event.slots.count.to_s
      end
    else
      "&mdash;".html_safe
    end
  end
end
