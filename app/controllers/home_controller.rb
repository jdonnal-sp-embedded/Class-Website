class HomeController < ApplicationController

  def index
    @month=Time.now.month
    @year=Time.now.year
    @shown_month=Date.civil(@year,@month)
    @event_strips=Event.event_strips_for_month(@shown_month)
  end

end
