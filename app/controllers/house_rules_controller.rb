class HouseRulesController < ApplicationController
  def index
       @rules = get_api('/house_rules', { :condo_id => session[:condo_id]  , :auth_token =>session[:auth_token]})
  end
  def show
  end  
end
