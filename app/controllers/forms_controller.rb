class FormsController < ApplicationController
  respond_to :js , :html , :json
  def index
    set_menu
    @forms = get_api('/forms', { :condo_id => session[:condo_id] ,:auth_token =>session[:auth_token]})
  end
  def show

  end   
    private
  def set_menu
    session[:menu] = :forms
  end
end
