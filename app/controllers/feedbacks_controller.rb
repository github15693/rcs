class FeedbacksController < ApplicationController
  require 'base64'
  respond_to :js , :html
  def new
  @cat = get_api('/list_cat', { :user_id => "2" })
  end
  def create

image = params[:image]

@feedback = post_api('/send_feedback' , {:user_id => "2" , :feedback_category_id => params[:feedback_category_id], :title => params[:title] ,
                     :content => params[:content] ,  image: {
           :content_type => image.content_type,
           :filename => image.original_filename,
           :file_data => Base64.encode64(image.read)
                              }
 })

  end  
end
