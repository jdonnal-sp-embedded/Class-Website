class Admin::SlotsController < ApplicationController
  before_filter :authenticate_user!

  respond_to :html, :json, :xml

  def create
    params[:slot][:start_at]=Event.parse_time_select(params[:slot],'start_at')
    params[:slot][:event_id]=params[:event_id]
    @slot=Slot.new(params[:slot])
    @slot.end_at=@slot.start_at+@slot.event.slot_duration.minutes
    @slot.save
    @slots=@slot.event.slots.ascending(:start_at)
  end
  
  def destroy
    @slot=Slot.find(params[:id])
    @slots=@slot.event.slots.ascending(:start_at)
    @slot.destroy
  end
end
