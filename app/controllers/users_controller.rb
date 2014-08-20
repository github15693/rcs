class UsersController < RootsController
  layout 'application'

  def edit
    json_user = api_get '/profile', {token: session[:token]}
    if json_user[:status] = 'success'
      @user = json_user[:data]
    end
  end

  def update
    user_params[:token] = session[:token]
    json_user = api_post '/edit_profile', user_params
  end

  private
    def user_params
      params.require(:user).permit(:name, :phone, :email)
    end

    def password_params
      params.require(:user).permit(:current_password, :password, :password_confirm)
    end
end

