class UsersController < RootsController
  skip_before_action :authenticate_user!

  def create
    @user = api_post '/log_in', user_params
    if @user[:status] == 'success'
      session[:user_id] = user[:user_id]
      session[:email] = user[:email]
      session[:name] = user[:name]
      session[:token] = user[:token]
      session[:condo_id] = user[:condo_id]
      render js: "window.location = '#{homes_url}'"
    end
  end

  def destroy
    session.destroy
    render js: "window.location = '#{root_url}'"
  end

  private
    def user_params
      params.require(:user).permit(:email, :password, :remember)
    end

    def user
      @user[:data]
    end
end

