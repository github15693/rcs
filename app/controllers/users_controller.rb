class UsersController < RootsController
  layout 'application'
  include ApplicationHelper
  def edit
    json_user = api_get '/profile', {auth_token: session[:auth_token]}
    if json_user[:status] = 'success'
      @user = json_user[:results]
    end
  end

  def update
    password_params.merge(auth_token: session[:auth_token])
    json_user = api_post '/edit_profile', user_params
  end

  def password
  end

  def show
    session[:profile_tab] = :info
  end

  def e_walet
    session[:profile_tab] = :e_walet
    temp_b = hash_to_object get_api('/check_booking',{user_id:session[:user_id], auth_token:session[:auth_token]})
    @check_bookings=temp_b.total > 0 ? temp_b.results : nil

    temp_pr = hash_to_object get_api('/my_privileges',{user_id:session[:user_id],auth_token:session[:auth_token]})
    @my_privileges=temp_pr.total > 0 ? temp_pr.results : nil
  end

  def update_password
    json_user = api_post '/change_password', password_params
    unless json_user[:status] == 'success'
      @errors = json_user[:message]
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :phone, :email, :auth_token)
    end

    def password_params
      params.require(:user).permit(:current_password, :password, :password_confirmation, :auth_token)
    end
end

