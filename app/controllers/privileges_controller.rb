class PrivilegesController < ApplicationController
  before_action :set_menu
  include ApplicationHelper
  def index
    @temp = hash_to_object get_api('/privileges',{user_id:session[:user_id], authentication_token:session[:token]})
    @privileges=@temp.data
  end

  def show
    @temp = hash_to_object get_api('/privilege_detail',{privilege_id:params[:id],authentication_token:session[:token]})
    @privilege=@temp.data
  end

  def redeem_previlege
    @results = hash_to_object post_api('/redeem_previlege',{privilege_id:params[:privilege_id],user_id:session[:user_id],authentication_token:session[:token]})
    @privilege=@results.data
  end

  private
  def set_menu
    session[:menu] = :privileges
  end
end
