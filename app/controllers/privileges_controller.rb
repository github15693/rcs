class PrivilegesController < ApplicationController
  before_action :set_menu
  include ApplicationHelper
  def index
    # @temp = hash_to_object get_api('/privileges',{user_id:session[:user_id], auth_token:session[:auth_token]})
    # @privileges=@temp.results
  end

  def show
    @temp = hash_to_object get_api('/privilege_detail',{privilege_id:params[:id],auth_token:session[:auth_token]})
    @privilege=@temp.total > 0 ? @temp.results : nil
  end

  def redeem_previlege
    @results = hash_to_object post_api('/redeem_previlege',{privilege_id:params[:privilege_id],user_id:session[:user_id],auth_token:session[:auth_token]})
    @privilege=@temp.total > 0 ? @temp.results : nil
  end

  private
  def set_menu
    session[:menu] = :privileges
  end
end
