class BulletinsController < ApplicationController
  before_action :set_menu
  def index
    #get total page from api
 
    limit = 2
    if params[:page]
    @current_page = params[:page]
    else
    @current_page = 1
    end
    @bulletins = get_api('/bulletins', {:page=>@current_page , :limit=>limit ,:condo_id => session[:condo_id] , :auth_token =>session[:auth_token]})
   @pages =    @bulletins[:total] % limit == 0 ? @bulletins[:total]/limit : @bulletins[:total]/limit +1

  end
  def show

     @bulletin =  get_api('/bulletin_detail', {:bulletin_id=>params[:id] , :auth_token =>session[:auth_token]})
  end 
    private
  def set_menu
    session[:menu] = :bulletins
  end 
end
