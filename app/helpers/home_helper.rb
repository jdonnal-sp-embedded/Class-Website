module HomeHelper
  
  
  def event_calendar_options
    {
      :year=>@year,
      :month=>@month,
      :event_strips=>@event_strips,
      :use_all_day=>true
    }
  end
  def event_calendar
    calendar event_calendar_options do |args|
      event = args[:event]
      link_to(event.name, event_path(event), :class=>"calendar-link", :rel=>'facebox')
      #%(<a href="#" class="calendar-link">#{event.name}</a>)
    end
  end
end
