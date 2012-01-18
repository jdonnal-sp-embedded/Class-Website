class Admin::EventsController < ApplicationController
  before_filter :authenticate_user!

  respond_to :html, :json, :xml
  layout 'application', :except=>:new
  
  def new
    @event=Event.new
    respond_with @event
  end
  
  def create
    #check to see if this is a valid operation
    raise "Illegal Operation" unless current_user.can_modify_events?
    
    params[:event][:start_at]=Event.parse_time_select(params[:event],"start_at")
    params[:event][:end_at]=Event.parse_time_select(params[:event],"end_at")
    @event=Event.new(params[:event])
    @event.save
    @events=Event.all.ascending(:start_at)
  end
  
  def destroy
    #check to see if this is a valid operation
    raise "Illegal Operation" unless current_user.can_modify_events?

    @event=Event.find(params[:id])
    @event.destroy
    @events=Event.all.ascending(:start_at)
    
  end
end
