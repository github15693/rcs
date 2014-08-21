class CoursesController < ApplicationController
  before_action :set_menu
  include ApplicationHelper

  def index
    @temp = hash_to_object get_api('/courses',{condo_id:session[:condo_id], auth_token:session[:auth_token]})
    @courses=@temp.total > 0 ? @temp.data : nil
  end

  def show
    @temp = hash_to_object get_api('/course_detail',{course_id:params[:id],auth_token:session[:auth_token]})
    @course=@temp.total > 0 ? @temp.data : nil
  end

  private
  def set_menu
    session[:menu] = :courses
  end
end
