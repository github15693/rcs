class UsersController < ApplicationController
  layout 'application'
  def show
      json_user = api_get '/profile', {auth_token: session[:auth_token]}
    if json_user[:status] = 'success'
      @user = json_user[:results]
    end
  end  
  def edit
    json_user = api_get '/profile', {auth_token: session[:auth_token]}
    if json_user[:status] = 'success'
      @user = json_user[:results]
    end
  end

  def update
    # password_params.merge(auth_token: session[:auth_token])
    # json_user = api_post '/edit_profile', user_params
    if params[:image]
image = params[:image]
@user = post_api('/edit_profile' , { :auth_token =>session[:auth_token] , :name=> params[:name], :phone => params[:phone] ,:city => params[:city],
                       image: {
           :content_type => image.content_type,
           :filename => image.original_filename ,
           :file_data => Base64.encode64(image.read)
                              }
 }) 
      else
 @user = post_api('/edit_profile' , { :auth_token =>session[:auth_token] , :name=> params[:name], :phone => params[:phone] ,:city => params[:city] })       
      end
 if @user[:status] == "success"
  redirect_to new_feedback_path ,:notice => t('feedback.new.send_success')
 else
  redirect_to homes_path, :error => t('feedback.new.send_fail')
 end 

  end

  def password
  end

  def update_password
    json_user = api_post '/change_password', password_params
    unless json_user[:status] == 'success'
      @errors = json_user[:message]
    end
  end

  private
   

    def password_params
      params.require(:user).permit(:current_password, :password, :password_confirmation, :auth_token)
    end
end

