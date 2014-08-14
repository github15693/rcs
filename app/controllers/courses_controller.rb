class CoursesController < ApplicationController
  before_action :set_menu
  include ApplicationHelper

  def index
    
  end

  def show
    
  end

  private
  def set_menu
    session[:menu] = :courses
  end
end
