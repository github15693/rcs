class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :get_privileges
  include ApplicationHelper
  def get_privileges
    @privileges = hash_to_object get_api('/privileges')
  end
end
