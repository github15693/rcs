class PrivilegesController < ApplicationController
  before_action :set_menu
  def index

  end

  private
  def set_menu
    session[:menu] = :privileges
  end
end
