class UsersController < ApplicationController
  # layout 'application'
  before_action :check_user


  def get_users
    session[:menu] = :users

    limit = 5
    unless params[:page].blank?
      @current_page = params[:page]
    else
      @current_page = 1
    end
    users = hash_to_object get_api('/get_users', {:page => @current_page, :limit => limit, :condo_id => session[:condo_id] ,:auth_token =>session[:auth_token]})
    @total_user = users[:total].blank? ? 0 : users[:total]
    @users = users.results.blank? ? nil : users.results
    if users.total == 0
      @pages = 1
    else
      @pages = users[:total] % limit == 0 ? users.total/limit : users.total/limit + 1
    end
  end

  def show
    session[:profile_tab] = :info
    # json_user = api_get '/profile', {auth_token: session[:auth_token]}
    #   if json_user[:status] == 'success'
    #     @user = json_user[:results]
    #   end

    my_booking = hash_to_object api_get('/my_bookings', {:auth_token => session[:auth_token], :user_id => session[:user_id]})
    @total_booking = my_booking.total
    @my_bookings = my_booking.results.blank? ? nil : my_booking.results
  end


  def edit
    json_user = api_get '/profile', {auth_token: session[:auth_token]}
    if json_user[:status] == 'success'
      @user = hash_to_object json_user[:results]
    end
  end

  def update
    # password_params.merge(auth_token: session[:auth_token])
    # json_user = api_post '/edit_profile', user_params
    if params[:image]
      image = params[:image]
      @user = post_api('/edit_profile', {:auth_token => session[:auth_token], :name => params[:name], :phone => params[:phone], :city => params[:city], :interest => params[:interest],
                                         image: {
                                             :content_type => image.content_type,
                                             :filename => image.original_filename,
                                             :file_data => Base64.encode64(image.read)
                                         }
      })
    else
      @user = post_api('/edit_profile', {:auth_token => session[:auth_token], :name => params[:name], :phone => params[:phone], :city => params[:city], :interest => params[:interest]})
    end
    if @user[:status] == "success"
      redirect_to user_path, :notice => t('users.send_success')
    else
      @errors = @user[:message]
      json_user = api_get '/profile', {auth_token: session[:auth_token]}
      if json_user[:status] == 'success'
        @user = json_user[:results]
      end
      render "edit", :error => t('users.send_fail')
    end

  end

  def password
  end


  def e_walet
    session[:profile_tab] = :e_walet
    temp_b = hash_to_object get_api('/check_booking', {user_id: session[:user_id], auth_token: session[:auth_token]})
    @check_bookings=temp_b.total > 0 ? temp_b.results : nil

    temp_pr = hash_to_object get_api('/my_privileges', {user_id: session[:user_id], auth_token: session[:auth_token]})
    @my_privileges=temp_pr.total > 0 ? temp_pr.results : nil
  end

  def update_password
    json_user = api_post '/change_password', password_params
    unless json_user[:status] == 'success'
      @errors = json_user[:message]
    end
  end

  private
  def check_user
    if @user.username == 'guest'
      redirect_to '/422.html'
    end
  end

  def password_params
    params.require(:user).permit(:current_password, :password, :password_confirmation, :auth_token)
  end
end

