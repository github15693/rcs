class EventsController < ApplicationController

  def index
    p PublicFunction.hash_to_object PublicFunction.post_api('/request_friend',{request_user_id:14, confirm_user_id:4})
  end

end
