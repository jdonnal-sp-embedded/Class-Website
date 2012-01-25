class HomeController < ApplicationController

  def index
    redirect_to :controller=>'info', :action=>'index' unless current_user
    
    @month=Time.now.month
    @year=Time.now.year
    @shown_month=Date.civil(@year,@month)
    @event_strips=Event.event_strips_for_month(@shown_month)
    
    #show all lab hours in the upcoming 7 days
    @hours=LabHour.upcoming
  end

end
