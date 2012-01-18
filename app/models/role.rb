class Role
  include Mongoid::Document
  field :name, :type => String
  field :description, :type => String
  
  #Possible User Roles:
  # student= current undergrad in the class
  # alumn= a student who has completed the class
  # drop= a student who is no longer in the class
  # ta= teaching assistant
  # la= lab assistant
  # admin= global administrator
  
  
  #testing methods
  def print_permissions
    self.permissions.each do |perm|
      puts sprintf("%s: \t %s",perm.name,perm.description)
    end
  end
  
  validates :name,
    :presence => true,
    :inclusion=> {:in =>['student','alumn','drop','ta','la','admin']}
    
  has_and_belongs_to_many :permissions
  
  
end
