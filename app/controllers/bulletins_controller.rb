class BulletinsController < ApplicationController
  def index
    #get total page from api
      
    limit = 2
    if params[:page]
    @current_page = params[:page]
    else
    @current_page = 1
    end
    @bulletins = hash_to_object get_api('/bulletins', {:page=>@current_page , :limit=>limit , :auth_token =>session[:auth_token]})
   @pages =    @bulletins.total % limit == 0 ? @bulletins.total/limit : @bulletins.total/limit +1

  end
  def show

     @bulletin = hash_to_object get_api('/bulletin_detail', {:bulletin_id=>params[:id] , :auth_token =>session[:auth_token]})
  end  
end
