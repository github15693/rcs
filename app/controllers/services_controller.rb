class ServicesController < ApplicationController
respond_to :js , :html , :json
def index
 @cat  = get_api('/service_categories', { :condo_id => "1" })
end
def get_service
 @services = get_api('/services' , {:service_category_id => params[:id]})
end  
def show
  @service = get_api('/service_detail' , { :service_id => params[:id] } )
end  

end
