class FormsController < ApplicationController
  respond_to :js , :html , :json
  before_action :check_user

  def index
    set_menu
    @forms = hash_to_object get_api('/forms', { :condo_id => session[:condo_id] ,:auth_token =>session[:auth_token]})

    limit = 5
    unless params[:page].blank?
      @current_page = params[:page]
    else
      @current_page = 1
    end
    forms = hash_to_object get_api('/get_forms', {:page => @current_page, :limit => limit, :condo_id => session[:condo_id] ,:auth_token =>session[:auth_token]})
    @total_form = forms[:total].blank? ? 0 : forms[:total]
    @forms = forms.results.blank? ? nil : forms.results
    if forms.total == 0
      @pages = 1
    else
      @pages = forms[:total] % limit == 0 ? forms.total/limit : forms.total/limit + 1
    end
  end

  def show

  end

  private
  def check_user
    if @user.username == 'guest'
      redirect_to '/422.html'
    end
  end

  def set_menu
    session[:menu] = :forms
  end
end
