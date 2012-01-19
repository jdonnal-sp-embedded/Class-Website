class Event
  include Mongoid::Document
  include EventCalendar
  
  #NOTE: the times are stored in GMT and must be converted to EST to make sense
  field :start_at, type: DateTime
  field :end_at, type: DateTime
  field :all_day, type: Boolean
  field :name, type: String
  field :type, type: String
  field :description, type: String
  field :slotable, type: Boolean
  field :gradeable, type: Boolean
  field :slot_duration, type: Integer
  POSSIBLE_SLOT_DURATIONS=[10,15,20,30,60] #duration in minutes
  
  #RELATIONSHIPS
  has_many :slots, :dependent=>:destroy
  
  #validators
  validates :name,
    :presence=>true
  validates :slot_duration,
    :presence=>false,
    :inclusion => {:in => POSSIBLE_SLOT_DURATIONS}
  validates :start_at,
    :presence=>true
  validates :end_at,
    :presence=>true
  validate :valid_times 
    
  def valid_times
    return unless self.end_at && self.start_at 
    errors.add(:end_at,"must be after the start time") if self.end_at <= self.start_at
    #validate slotable events
    if self.slotable?
      unless self.slot_duration
        errors.add(:slot_duration,"cannot be blank") 
      else
        duration=self.end_at.to_i-self.start_at.to_i
        errors.add(:end_at, "must be a multiple of slots") unless (duration % (slot_duration*60)) ==0
      end
    end
  end
  
  
  def self.parse_time_select(hash,value)
    year=hash[value+'(1i)']
    month=hash[value+'(2i)']
    day=hash[value+'(3i)']
    hour=hash[value+'(4i)']
    minute=hash[value+'(5i)']
    Time.parse("#{year}-#{month}-#{day} #{hour}:#{minute}")
  end

  ##############################################
  #########CALENDAR METHODS#####################
  ##############################################
  
  before_save :adjust_all_day_dates
  # For the given month, find the start and end dates
  # Find all the events within this range, and create event strips for them
  def event_strips_for_month(shown_date, first_day_of_week=0, find_options = {})
    if first_day_of_week.is_a?(Hash)
      find_options.merge!(first_day_of_week)
      first_day_of_week =  0
    end
    strip_start, strip_end = get_start_and_end_dates(shown_date, first_day_of_week)
    events = events_for_date_range(strip_start, strip_end, find_options)
    event_strips = create_event_strips(strip_start, strip_end, events)
    event_strips
  end
  
  # Expand start and end dates to show the previous month and next month's days,
  # that overlap with the shown months display
  def get_start_and_end_dates(shown_date, first_day_of_week=0)
    # start with the first day of the given month
    start_of_month = Date.civil(shown_date.year, shown_date.month, 1)
    # the end of last month
    strip_start = beginning_of_week(start_of_month, first_day_of_week)
    # the beginning of next month, unless this month ended evenly on the last day of the week
    if start_of_month.next_month == beginning_of_week(start_of_month.next_month, first_day_of_week)
      # last day of the month is also the last day of the week
      strip_end = start_of_month.next_month
    else
      # add the extra days from next month
      strip_end = beginning_of_week(start_of_month.next_month + 7, first_day_of_week)
    end
    [strip_start, strip_end]
  end
  
  # Get the events overlapping the given start and end dates
  def events_for_date_range(start_d, end_d, find_options = {})
    self.where(:end_at.gte => start_d).and(:start_at.lt => end_d).order_by([:start_at, :asc])
    
  end
  
  # Create the various strips that show events.
  def create_event_strips(strip_start, strip_end, events)
    # create an inital event strip, with a nil entry for every day of the displayed days
    event_strips = [[nil] * (strip_end - strip_start + 1)]
  
    events.each do |event|
      cur_date = event.start_at.in_time_zone.to_date
      end_date = event.end_at.in_time_zone.to_date
      cur_date, end_date = event.clip_range(strip_start, strip_end)
      start_range = (cur_date - strip_start).to_i
      end_range = (end_date - strip_start).to_i
    
      # make sure the event is within our viewing range
      if (start_range <= end_range) and (end_range >= 0) 
        range = start_range..end_range
        
        open_strip = space_in_current_strips?(event_strips, range)
        
        if open_strip.nil?
          # no strips open, make a new one
          new_strip = [nil] * (strip_end - strip_start + 1)
          range.each {|r| new_strip[r] = event}
          event_strips << new_strip
        else
          # found an open strip, add this event to it
          range.each {|r| open_strip[r] = event}
        end
      end
    end
    event_strips
  end
  
  def space_in_current_strips?(event_strips, range)
    open_strip = nil
    for strip in event_strips
      strip_is_open = true
      range.each do |r|
        # overlapping events on this strip
        if !strip[r].nil?
          strip_is_open = false
          break
        end
      end

      if strip_is_open
        open_strip = strip
        break
      end
    end
    open_strip
  end
  
  def days_between(first, second)
    if first > second
      second + (7 - first)
    else
      second - first
    end
  end

  def beginning_of_week(date, start = 0)
    days_to_beg = days_between(start, date.wday)
    date - days_to_beg
  end
  

# Instance Methods
# Override in your model as needed
  def year
    date.year
  end

  def month
    date.month
  end
 
  def day
    date.day
  end
    
  def all_day
    self[:all_day]
  end
    
  def color
    self[:color] || '#9aa4ad'
  end

  def days
    end_at.in_time_zone.to_date - start_at.in_time_zone.to_date
  end

  # start_d - start of the month, or start of the week
  # end_d - end of the month, or end of the week
  def clip_range(start_d, end_d)
    # make sure we are comparing date objects to date objects,
    # otherwise timezones can cause problems
    start_at_d = start_at.in_time_zone.to_date
    end_at_d = end_at.in_time_zone.to_date
    # Clip start date, make sure it also ends on or after the start range
    if (start_at_d < start_d and end_at_d >= start_d)
      clipped_start = start_d
    else
      clipped_start = start_at_d
    end
  
    # Clip end date
    if (end_at_d > end_d)
      clipped_end = end_d
    else
      clipped_end = end_at_d
    end
    [clipped_start, clipped_end]
  end

  def adjust_all_day_dates
    if self.all_day
      self.start_at = self.start_at.in_time_zone.beginning_of_day

      if self.end_at
        self.end_at = self.end_at.in_time_zone.beginning_of_day + 1.day - 1.second
      else
        self.end_at = self.start_at + 1.day - 1.second
      end
    end
  end
end
