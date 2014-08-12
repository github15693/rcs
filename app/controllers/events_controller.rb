class EventsController < ApplicationController
  before_action :set_menu
  def index
    p hash_to_object post_api('/request_friend',{request_user_id:14, confirm_user_id:4})
  end

  private
  def set_menu
    session[:menu] = :events
  end
end
