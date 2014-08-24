class EventsController < ApplicationController
  before_action :set_menu
respond_to :html , :js

def index
    #get total page from api
      
    limit = 2

    if params[:page]
    @current_page = params[:page]
    else
    @current_page = 1
    end
   @events =    get_api('/events', {:page=>@current_page , :limit=>limit , :auth_token =>session[:auth_token] , :condo_id =>session[:condo_id]})


   @pages  =   @events[:total] % limit == 0 ? @events[:total]/limit : @events[:total]/limit +1


end 
def show
     @event = get_api('/event_detail', {:event_id=>params[:id] , :auth_token =>session[:auth_token]})
     @list_user = get_api('/list_user' , {:event_id=>params[:id]  , :auth_token =>session[:auth_token]})
     @all_image = get_api('/event_detail_photo', {:event_id=>params[:id] , :auth_token =>session[:auth_token]})
end  
def join
    @join_event = post_api('/join_event' , {:user_id => session[:user_id] , :event_id => params[:id] , :auth_token =>session[:auth_token]})
    @list_user = get_api('/list_user' , {:event_id=>params[:id]  , :auth_token =>session[:auth_token] ,:user_id => session[:user_id]})
end
def photo    
end  




  private
  def set_menu
    session[:menu] = :events
  end

end
