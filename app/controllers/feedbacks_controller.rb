class FeedbacksController < ApplicationController
  require 'base64'
  respond_to :js , :html
  def new
    set_menu
  @cat = get_api('/list_subject', { :condo_id => session[:condo_id] ,:auth_token =>session[:auth_token]})
  end
  def create

image = params[:image]

@feedback = post_api('/send_feedback' , { :auth_token =>session[:auth_token] , :user_id => session[:user_id] , :subject_id=> params[:feedback_category_id], :title => params[:title] ,
                     :content => params[:content] , 
                       image: {
           :content_type => image.content_type,
           :filename => image.original_filename ,
           :file_data => Base64.encode64(image.read)
                              }
 })
 if @feedback[:status] == "success"
  redirect_to new_feedback_path ,:notice => t('feedback.new.send_success')
 else
  redirect_to homes_path, :error => t('feedback.new.send_fail')
 end 

  end
  private
  def set_menu
    session[:menu] = :feedbacks
  end
end
