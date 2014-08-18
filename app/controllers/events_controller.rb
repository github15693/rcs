class EventsController < ApplicationController
respond_to :html , :js
  # def index
  #   p hash_to_object post_api('/request_friend',{request_user_id:14, confirm_user_id:4})
  # end
def index
    #get total page from api
      
    limit = 2

    if params[:page]
    @current_page = params[:page]
    else
    @current_page = 1
    end
   @events =   hash_to_object get_api('/events', {:page=>@current_page , :limit=>limit , :authentication_token =>"c6sUskHTsLAhfLXPTVcG" ,:user_id => 2})


   @pages  =   @events.total % limit == 0 ? @events.total/limit : @events.total/limit +1


end 
def show
     @event = get_api('/event_detail', {:event_id=>params[:id]})
     @list_user = get_api('/list_user' , {:event_id=>params[:id] , :user_id => 2})
     @all_image = get_api('/event_detail_photo', {:event_id=>params[:id]})
end  
def join
    @join_event =hash_to_object post_api('/join_event' , {:user_id => 2 , :event_id => params[:id]})
    @list_user = get_api('/list_user' , {:event_id=>params[:id] , :user_id => 2})
end
def photo    
end  
end
