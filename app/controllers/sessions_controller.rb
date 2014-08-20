class SessionsController < RootsController
  skip_before_action :authenticate_user!

  def create
    json_session = api_post '/log_in', session_params
    @session = json_session[:status]
    if json_session[:status] == 'success'
      session[:user_id] = json_session[:data][:user_id]
      session[:email] = json_session[:data][:email]
      session[:name] = json_session[:data][:name]
      session[:token] = json_session[:data][:token]
      session[:condo_id] = json_session[:data][:condo_id]
      render js: "window.location = '#{homes_url}'"
    end
  end

  def destroy
    json_session = api_post '/log_out', {token: session[:token]}
    if json_session[:status] = 'success'
      session.destroy
      render js: "window.location = '#{root_url}'"
    end
  end

  private
    def session_params
      params.require(:user).permit(:email, :password, :remember)
    end
end

