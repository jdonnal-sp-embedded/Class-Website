class Admin::LabHoursController < ApplicationController
 before_filter :authenticate_user!

  respond_to :html, :json, :xml
  layout 'application', :except=>:new
  
  def new
    @lab_hour=LabHour.new
    @lab_hour.user=current_user
    respond_with @lab_hour
  end 
  
  def create
    params[:lab_hour][:start_at]=Event.parse_time_select(params[:lab_hour],"start_at")
    @hour=LabHour.new(params[:lab_hour])
    @hour.end_at=@hour.start_at.in_time_zone+params[:length].to_i.minutes
    #make sure this is a legal action
    return unless (current_user.can_add_lab_hours? && @hour.user==current_user) ||current_user.can_modify_lab_hours?
    
    @hour.save
    @hours=LabHour.upcoming
  end
  
  def destroy
    @hour=LabHour.find(params[:id])
    #make sure this is a legal action
     return unless (current_user.can_add_lab_hours? && @hour.user==current_user) ||current_user.can_modify_lab_hours?
     
    @hour.destroy
    @hours=LabHour.upcoming
  end
  
end
