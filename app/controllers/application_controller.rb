class ApplicationController < RootsController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :get_privileges, :get_last_bulletins

  include ApplicationHelper

  def get_privileges
    @temp = hash_to_object get_api('/privileges',{user_id:session[:user_id],auth_token:session[:auth_token]})
    @privileges=@temp.total > 0 ? @temp.results : nil
  end

  def get_last_bulletins
    @temp = hash_to_object get_api('/bulletins',{auth_token:session[:auth_token]})
    @bulletin=@temp.total > 0 ? @temp.results[0] : nil
  end

  def temp_session
    session[:token]= 'pVoci-MmcHcoWNvzynbL'
    session[:user_id] =7
    session[:condo_id] =1
  end
end

