class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :get_privileges, :get_last_bulletins, :set_locale

  include ApplicationHelper

  def get_privileges
    @temp = hash_to_object get_api('/privileges')
    @privileges=@temp.data
  end

  def get_last_bulletins
    @temp = hash_to_object get_api('/bulletins')
    @bulletin=@temp.total > 0 ? @temp.data[0] : nil
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(options={})
    logger.debug "default_url_options is passed options: #{options.inspect}\n"
    { locale: I18n.locale }
  end
end

