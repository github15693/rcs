class WelcomesController < RootsController
  # layout 'adminLte' #welcome
  before_action :set_menu
  skip_before_action :authenticate_user!
  before_action :redirect_to_home

  def index
    json_condo = api_get '/condos'
    if json_condo[:status] = 'success'
      @condos = []
      json_condo[:results].each do |condo|
        @condos << condo.values
      end
    end
  end

  def create
    json_user = api_post '/sign_up', user_params
    @user = json_user[:status]
    @errors = json_user[:message] unless @user == 'success'
  end

  private
    def set_menu
      session[:menu] = :welcomes
    end

    def user_params
      params.require(:user).permit(:name, :email, :phone, :city, :password, :password_confirmation, :condo_id)
    end

    def redirect_to_home
      unless session[:auth_token].blank?
        redirect_to homes_url
      end
    end
end

