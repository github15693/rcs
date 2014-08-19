class MediaController < RootsController
  layout 'welcome'
  before_action :set_menu
  skip_before_action :authenticate_user!

  def index
  end

  private
    def set_menu
      session[:menu] = :media
    end
end

