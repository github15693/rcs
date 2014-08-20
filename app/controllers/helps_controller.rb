class HelpsController < ApplicationController
  def support
    json_help = api_get '/tech_support'
    if json_help[:status] == 'success'
      @help = json_help[:data]
    end
  end

  def about
    json_help = api_get '/about_us'
    if json_help[:status] == 'success'
      @help = json_help[:data]
    end
  end
end

