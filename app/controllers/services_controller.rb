class ServicesController < ApplicationController
respond_to :js , :html , :json
before_action :set_menu
def index

 @cat  = get_api('/service_categories', { :condo_id => session[:condo_id] , :auth_token =>session[:auth_token]})
end
def get_service
 @services = get_api('/services' , {:service_category_id => params[:id] , :auth_token =>session[:auth_token]})
end  
def show
  @service = get_api('/service_detail' , { :service_id => params[:id] ,:auth_token =>session[:auth_token] } )
end  
  private
  def set_menu
    session[:menu] = :services
  end
end
