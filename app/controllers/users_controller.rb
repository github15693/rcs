class UsersController < RootsController
  def create
    @user = api_post '/log_in', user_params
    if @user[:status] == 'success'
      session[:user_id] = user[:user_id]
      session[:email] = user[:email]
      session[:name] = user[:name]
      session[:token] = user[:token]
      session[:condo_id] = user[:condo_id]
      if user_params[:remember]
        cookies[:user_id] = user[:user_id]
        cookies[:email] = user[:email]
        cookies[:name] = user[:name]
        cookies[:token] = user[:token]
        cookies[:condo_id] = user[:condo_id]
      end
    end
  end

  private
    def user_params
      params.require(:user).permit(:email, :password, :remember)
    end

    def user
      @user[:data]
    end
end

