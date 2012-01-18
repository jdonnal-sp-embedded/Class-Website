class EventsController < ApplicationController
  respond_to :html, :json, :xml
  layout 'application', :except=>:show
  
  def show
    @event = Event.find(params[:id])
    if current_user
      if current_user.can_modify_slots?
        #show all slots
        @slots=@event.slots
        #find all the possible slot hosts
        host_roles=Permission.where(name: "host_slots").first.roles
        @hosts=[]
        host_roles.each do |role|
          users=User.where(role_id: role.id)
          users.each do |user|
            @hosts << user
          end
        end
      elsif current_user.can_create_slots?
        #only show this users slots
        @slots=@event.slots.where(host_id: current_user.id)
      elsif current_user.can_attend_slots?
        #show all available slots
        @slots=@event.slots.where(attendee_id: nil)
      end
    end
  end
end
