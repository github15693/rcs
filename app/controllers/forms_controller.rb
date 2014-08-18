class FormsController < ApplicationController
  respond_to :js , :html , :json
  def index
    @forms = get_api('/forms', { :condo_id => "1" })
  end
  def show

  end   
end
