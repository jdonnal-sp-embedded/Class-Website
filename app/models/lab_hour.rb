class LabHour
  include Mongoid::Document
  
  field :start_at, type: DateTime
  field :end_at, type: DateTime
  field :comment, type: String
  
  belongs_to :user
  
  
  validates :end_at,
    :presence=>true
  validates :start_at,
    :presence=>true
  validates :user,
    :presence=>true
  validate :valid_times
  validate :no_conflicts
  
  scope :upcoming, where(:end_at.gte=>Time.now).where(:start_at.lte=>1.week.from_now).asc(:start_at)

  def valid_times
    return unless self.end_at && self.start_at 
    errors.add(:end_at,"must be after the start time") if self.end_at <= self.start_at
  end
  
   def no_conflicts
    #make sure the host doesn't have any other slots during this time
    return unless self.user
    other_hours=self.user.lab_hours
    other_hours.each do |other_hour|
      next if other_hour.id==self.id #don't compare a slot to itself
      if time_conflict?(other_hour)
         errors.add(:start_at, " schedule conflict") 
         break
      end
    end
  end
  
  def time_conflict? (other_hour)
    #ask jim how to this works. ask bj how of to spell and write right
    return false if self.end_at <= other_hour.start_at
    return false if self.start_at >= other_hour.end_at
    return true
  end
  
  
end
