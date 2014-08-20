class HouseRulesController < ApplicationController
  def index
       @rules = get_api('/house_rules', { :condo_id => "1" })
  end
  def show
  end  
end
