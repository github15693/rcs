class WelcomesController < RootsController
  layout 'welcome'
  before_action :set_menu

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
    @user = api_post '/sign_up', user_params
    @errors = @user[:message] unless @user[:status] == 'success'
  end

  private
    def set_menu
      session[:menu] = :welcomes
    end

    def user_params
      params.require(:user).permit(:name, :email, :phone, :city, :password, :retype_password, :condo_id)
    end
end

