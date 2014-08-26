class HouseRulesController < ApplicationController
  def index
    set_menu
       @rules = get_api('/house_rules', { :condo_id => session[:condo_id]  , :auth_token =>session[:auth_token]})
  end
  def show
  end  
    private
  def set_menu
    session[:menu] = :house_rules
  end
end
