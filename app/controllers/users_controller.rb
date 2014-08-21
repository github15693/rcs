class UsersController < RootsController
  layout 'application'

  def edit
    json_user = api_get '/profile', {auth_token: session[:auth_token]}
    if json_user[:status] = 'success'
      @user = json_user[:results]
    end
  end

  def update
    user_params[:auth_token] = session[:auth_token]
    json_user = api_post '/edit_profile', user_params
  end

  def update_password
    password_params << {auth_token: session[:auth_token]}
    json_user = api_post '/change_password', password_params
  end

  private
    def user_params
      params.require(:user).permit(:name, :phone, :email)
    end

    def password_params
      params.require(:user).permit(:current_password, :password, :password_confirm)
    end
end

