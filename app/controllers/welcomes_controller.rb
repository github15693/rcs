class WelcomesController < ApplicationController
  layout 'welcome'
  before_action :set_menu

  def index
    @user = nil
  end

  def create

  end

  private
    def set_menu
      session[:menu] = :home
    end
end

