class GuardHousesController < ApplicationController
  before_action :set_menu

  def index
    guard_houses = hash_to_object get_api('/guard_houses',{condo_id:session[:condo_id], auth_token:session[:auth_token]})
    @guard_houses= guard_houses.total > 0 ? guard_houses.results : nil
  end

  private
  def set_menu
    session[:menu] = :guard_houses
  end
end
