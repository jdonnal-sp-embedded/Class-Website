class UsersController < ApplicationController
  before_filter :authenticate_user!

  respond_to :html, :json, :xml
  layout 'application', :except=>:edit
 
  def show
    @user = User.find(params[:id])
  end

  def edit
    @user=User.find(params[:id])
    return nil unless @user==current_user || current_user.can_modify_users?
  end
  
  def update
    @user=User.find(params[:id])
    @user.update_attributes(params[:user])
    @user.save
  end
end
