class FormsController < ApplicationController
  respond_to :js , :html , :json
  def index
    set_menu
    @forms = hash_to_object get_api('/forms', { :condo_id => session[:condo_id] ,:auth_token =>session[:auth_token]})

    limit = 5
    unless params[:page].blank?
      @current_page = params[:page]
    else
      @current_page = 1
    end
    forms = hash_to_object get_api('get_forms', {:condo_id => session[:condo_id] ,:auth_token =>session[:auth_token]})
    if forms.total == 0
      @pages = 1
    else
      @pages = forms[:total] % limit == 0 ? forms.total/limit : forms.total/limit + 1
    end
  end
  def show

  end   
    private
  def set_menu
    session[:menu] = :forms
  end
end
