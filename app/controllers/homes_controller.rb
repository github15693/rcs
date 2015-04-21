class HomesController < ApplicationController
  before_action :set_menu
  # layout 'homes'
  def index
    bulletin = hash_to_object get_api('/bulletins', {:page=>1 , :limit=>3 ,:condo_id => session[:condo_id] , :auth_token =>session[:auth_token]})
    if bulletin.status == 'success'
      @bulletins = bulletin.results
    end
    event = hash_to_object get_api('/events', {:page=>1 , :limit=> 3 ,:condo_id => session[:condo_id] , :auth_token =>session[:auth_token]})
    if event.status == 'success'
      @events = event.results
    end
    privilege = hash_to_object get_api('/privileges', {user_id:session[:user_id],auth_token:session[:auth_token]})
    if privilege.status == 'success'
      @privileges = privilege.results.take 3
    end
  end

  private
  def set_menu
    session[:menu] = :homes
  end
end
