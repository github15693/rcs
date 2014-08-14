class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action  :temp_session, :get_privileges, :get_last_bulletins, :set_locale

  include ApplicationHelper

  def get_privileges
    @temp = hash_to_object get_api('/privileges',{user_id:session[:user_id],authentication_token:session[:token]})
    @privileges=@temp.data
  end

  def get_last_bulletins
    @temp = hash_to_object get_api('/bulletins',{authentication_token:session[:token]})
    @bulletin=@temp.total > 0 ? @temp.data[0] : nil
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options options = {}
    logger.debug "default_url_options is passed options: #{options.inspect}\n"
    { locale: I18n.locale }
  end

  def temp_session
    session[:token]= 'iMXnuxVicLRLRysLtjUN'
    session[:user_id] =14
  end
end

