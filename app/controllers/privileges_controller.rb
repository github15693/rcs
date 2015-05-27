class PrivilegesController < ApplicationController
  before_action :set_menu
  include ApplicationHelper
  def index
    limit = 5

    if params[:page]
      @current_page = params[:page]
    else
      @current_page = 1
    end
    privileges = hash_to_object get_api('/privileges', {:page => @current_page, :limit => limit, user_id:session[:user_id], auth_token:session[:auth_token]})
    @pages = privileges[:total] % limit == 0 ? privileges[:total]/limit : privileges[:total]/limit +1
    @total_privilege = privileges[:total].blank? ? 0 : privileges[:total]
    @privileges = privileges.results.blank? ? nil : privileges.results

     # @temp = hash_to_object get_api('/privileges',{user_id:session[:user_id], auth_token:session[:auth_token]})
     # @privileges=@temp.results
  end

  def show
    @temp = hash_to_object get_api('/privilege_detail',{privilege_id:params[:id],auth_token:session[:auth_token]})
    @privilege=@temp.total > 0 ? @temp.results : nil
  end

  def redeem_previlege
    @results = hash_to_object post_api('/redeem_previlege',{privilege_id:params[:privilege_id],user_id:session[:user_id],auth_token:session[:auth_token]})
    @privilege=@results.total > 0 ? @results.results : nil
  end

  def my_privileges
    @temp = hash_to_object get_api('/my_privileges',{user_id:session[:user_id],auth_token:session[:auth_token]})
    @my_privileges=@temp.total > 0 ? @temp.results : nil
  end

  def delete_my_privilege
    post_api('/delete_my_privilege',{privilege_id:params[:privilege_id],auth_token:session[:auth_token]})
    @temp = hash_to_object get_api('/my_privileges',{user_id:session[:user_id],auth_token:session[:auth_token]})
    @my_privileges=@temp.total > 0 ? @temp.results : nil
  end

  private
  def set_menu
    session[:menu] = :privileges
  end
end
