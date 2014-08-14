class MediaController < ApplicationController
  layout 'welcome'
  before_action :set_menu

  def index
  end

  private
    def set_menu
      session[:menu] = :media
    end
end

