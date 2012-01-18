class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #FIELDS
  field :first_name
  field :last_name
  field :username
  #email and password are managed by devise
  
  #RELATIONSHIPS
  belongs_to :role
  delegate :permissions, :to => :role
  has_many :slots
  
  #SCOPES
  scope :admins, where(role_id: Role.where(:name=>"admin").first.id)
  scope :tas, where(role_id: Role.where(:name=>"ta").first.id)
  scope :las, where(role_id: Role.where(:name=>"la").first.id)
  scope :students, where(role_id: Role.where(:name=>"student").first.id)
  
  #VALIDATIONS
  
  validates :username,
    :presence => true,
    :uniqueness=>{:case_sensitive=>false}
  validates :role,
    :presence => true
  validates :email,
    :uniqueness=>{:case_sensitive=>false},
    :presence=>true
  attr_accessible :username, :first_name, :last_name, :email, :password, :password_confirmation, :remember_me
  
  
  def method_missing(method_id, *args)
    if match= matches_dynamic_role_check?(method_id)
      tokenize_roles(match.captures.first).each do |check|
        return true if role.name.downcase == check
      end
    return false
    elsif match = matches_dynamic_perm_check?(method_id)
      if permissions.where(name: match.captures.first).first
        return true
      else
        return false
      end
    else
      super
    end
  end

  #testing
  def print_permissions
    self.role.print_permissions
  end
  
  private

  def matches_dynamic_perm_check?(method_id)
    /^can_([a-zA-Z]\w*)\?$/.match(method_id.to_s)
  end
  
  def matches_dynamic_role_check?(method_id)
    /^is_an?_([a-zA-Z]\w*)\?/.match(method_id.to_s)
  end
  
  def tokenize_roles(string_to_split)
    string_to_split.split(/_or_/)
  end
  
end
