class WelcomesController < RootsController
  layout 'welcome'
  before_action :set_menu
  skip_before_action :authenticate_user!

  def index
    json_condo = api_get '/condos'
    if json_condo[:status] = 'success'
      @condos = []
      json_condo[:result].each do |condo|
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
      params.require(:user).permit(:name, :email, :phone, :city, :password, :retype_password, :condo_id)
    end
end

