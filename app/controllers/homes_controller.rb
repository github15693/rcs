class HomesController < ApplicationController
  before_action :set_menu
  # layout 'homes'
  def index
    bulletin = hash_to_object get_api('/bulletins', {:page=>1 , :limit=>1 ,:condo_id => session[:condo_id] , :auth_token =>session[:auth_token]})
    if bulletin.status == 'success'
      @bulletins = bulletin.results
    end
    event = hash_to_object get_api('/events', {:page=>1 , :limit=> 1 ,:condo_id => session[:condo_id] , :auth_token =>session[:auth_token]})
    if event.status == 'success'
      @events = event.results
    end
    privilege = hash_to_object get_api('/privileges', {user_id:session[:user_id],auth_token:session[:auth_token]})
    if privilege.status == 'success'
      @privileges = privilege.results.take 1
    end

    facilites = hash_to_object get_api('/get_facilities', {:condo_id => session[:condo_id], auth_token: session[:auth_token]})
    @facilites = facilites.total > 0 ? facilites.results.take(3) : nil

    users = hash_to_object get_api('/get_users', {:condo_id => session[:condo_id], auth_token: session[:auth_token]})
    @users = users.total > 0 ? users.results.take(8) : nil
  end

  private
  def set_menu
    session[:menu] = :homes
  end
end
