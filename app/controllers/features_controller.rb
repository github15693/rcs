class FeaturesController < RootsController
  layout 'welcome'
  before_action :set_menu

  def index
  end

  private
    def set_menu
      session[:menu] = :features
    end
end

