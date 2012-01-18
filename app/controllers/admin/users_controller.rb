class Admin::UsersController < ApplicationController
  before_filter :authenticate_user!

  respond_to :html, :json, :xml
  layout 'application', :except=>:new
  
  def new
    @user = User.new
    case params[:type]
    when 'admin'
      @user.role=Role.where(name: "admin").first
      @acct_type="Administrator"
    when 'la'
      @user.role=Role.where(name: "la").first
      @acct_type="Lab Assistant"
    when 'ta'
      @user.role=Role.where(name: "ta").first
      @acct_type="Teaching Assistant"
    when 'student'
      @user.role=Role.where(name: "student").first
      @acct_type="Student"
    else
      flash[:error]="Unknown user role or none given"
      @user=nil
    end
    @role=params[:type]
    respond_with @user
  end
  
  def create
    @user=User.new(params[:user])
    @user.role=Role.where(name: params[:role]).first
    #check authorization before continuing
    case params[:role]
    when 'admin'
      raise 'Illegal Operation' unless current_user.can_modify_admins?
    when 'ta'
      raise 'Illegal Operation' unless current_user.can_modify_tas?
    when 'la'
      raise 'Illegal Operation' unless current_user.can_modify_las?
    when 'student'
      raise 'Illegal Operation' unless current_user.can_modify_students?
    end
    
    @user.email=@user.username+"@mit.edu" unless @user.username == nil
    generated_password=Devise.friendly_token.first(6)
    @user.password=generated_password
    @role=params[:role]
    @users=User.where(:role_id=>@user.role_id)
    @user.save
    RegistrationMailer.welcome_email(@user,generated_password).deliver
  end
  
  def destroy
    @user=User.find(params[:id])
    #check authorization before continuing
    case @user.role.name
    when 'admin'
      raise 'Illegal Operation' unless current_user.can_modify_admins?
    when 'ta'
      raise 'Illegal Operation' unless current_user.can_modify_tas?
    when 'la'
      raise 'Illegal Operation' unless current_user.can_modify_las?
    when 'student'
      raise 'Illegal Operation' unless current_user.can_modify_students?
    end
    
    @user.destroy
    @role=@user.role.name
    @users=User.where(:role_id=>@user.role_id)
    
  end
  
end