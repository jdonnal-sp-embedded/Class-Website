class Slot
  include Mongoid::Document
  
  #fields
  field :start_at
  field :end_at
  
  #relationships
  belongs_to :host, :class_name => "User"
  belongs_to :attendee, :class_name=>"User"
  belongs_to :event
  
  #scopes
  scope :available, where(attendee_id: nil)
 
  #validators
  validates :host,
    :presence=>true
  validates :event,
    :presence=>true
  validates :start_at,
    :presence=>true
  validates :end_at,
    :presence=>true
  
  validate :valid_times
  
  validate :no_conflicts
  
  def valid_times
    #ensure the slot occurs during the event
    return unless self.event && self.start_at && self.end_at
    errors.add(:end_at," start must be before end") unless self.event.start_at < self.event.end_at
    if self.start_at<self.event.start_at || self.end_at > self.event.end_at
      errors.add(:end_at,"must occur during event")
    end
  end
  
  def no_conflicts
    #make sure the host doesn't have any other slots during this time
    return unless self.event && self.host
    other_slots=self.host.hosting_slots + self.host.attending_slots
    other_slots.each do |other_slot|
      next if other_slot.id==self.id #don't compare a slot to itself
      if time_conflict?(other_slot)
         errors.add(:end_at, " schedule conflict") 
         break
      end
    end
  end
  
  def available?
    return true if attendee==nil
    false
  end
  
  
  def time_conflict? (other_slot)
    #ask jim how to this works. ask bj how of to spell and write right
    return false if self.end_at <= other_slot.start_at
    return false if self.start_at >= other_slot.end_at
    return true
    
    

    #                               |--self--|
    # |--other_slot--|

    #conflict type 1
    # |--self--|
    #        |--other_slot--|
    #return true if self.end_at>other_slot.start_at
    
    #conflict type 2
    #        |--self--|
    #  |--slot2--|
   # return true if other_slot.end_at>self.start_at
    
    #conflict type 3
    #  |------self-----|
    #      |--slot 2--|
    #return true if self.start_at<other_slot.start_at && self.end_at > other_slot.end_at
    
    #conflict type 4
    #      |--self--|
    #   |----slot 2------|
    #return true if other_slot.start_at<self.start_at && other_slot.end_at > self.end_at
    
    return false
  end
end
