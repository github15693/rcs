class GuardHousesController < ApplicationController
  before_action :set_menu

  def index
    @temp = hash_to_object get_api('/guard_houses',{condo_id:session[:condo_id], auth_token:session[:auth_token]})
    @guard_houses=@temp.total > 0 ? @temp.results : nil
  end

  private
  def set_menu
    session[:menu] = :guard_houses
  end
end
