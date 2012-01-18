class AdminController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @admins=User.admins
    @tas=User.tas
    @las=User.las
    @students=User.students
    
    @events=Event.all.ascending(:start_at)
  end
  
end
