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
 
  def available?
    return true if attendee==nil
    false
  end
  
end
