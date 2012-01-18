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
  has_many :slots
  
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

  has_event_calendar
end
