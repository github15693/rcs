class RootsController < ActionController::Base
  before_action :set_locale
  before_action :authenticate_user!
  before_action :get_user_info
  layout 'adminLte'
  include ApplicationHelper

  def get_user_info
    if session[:auth_token].blank?
      json_session = post_api '/log_in', {:email => 'guest@rms.com', :password => '12345678'}
      @session = json_session[:status]
      if json_session[:status] == 'success'
        session[:user_id] = json_session[:results][:user_id]
        session[:email] = json_session[:results][:email]
        session[:name] = json_session[:results][:name]
        session[:auth_token] = json_session[:results][:auth_token]
        session[:condo_id] = json_session[:results][:condo_id]
        # render js: "window.location = '#{homes_url}'"
      end
    end

    json_user = get_api '/profile', {auth_token: session[:auth_token]}
    if json_user[:status] == 'success'
      @user = hash_to_object json_user[:results]
    end
  end

  def authenticate_user!
    if session[:auth_token].blank?
      redirect_to welcomes_url
    end
  end

  def set_locale
    I18n.locale = params[:locale] || :vi #I18n.default_locale
  end

  def default_url_options options = {}
    logger.debug "default_url_options is passed options: #{options.inspect}\n"
    { locale: I18n.locale }
  end

  def rest_client url, http_usr = nil, http_pwd = nil
    uri = api_domain + url
    RestClient::Resource.new uri, http_usr, http_pwd
  end

  def api_get url, query_params = {}, http_usr = nil, http_pwd = nil
    uri = url << api_params(query_params).to_s
    JSON.parse rest_client(uri, http_usr, http_pwd).get, symbolize_names: true
  end

  def api_post url, query_params, http_usr = nil, http_pwd = nil
    params = query_params#.to_json
    JSON.parse rest_client(url, http_usr, http_pwd).post(params, content_type: "application/json"), symbolize_names: true
  end

  private
    def api_domain
      'http://rms.innoria.com/api'
    end

    def api_params query_params = {}
      queries = '?' unless query_params.empty?
      key_last = query_params.keys.last
      query_params.each do |key, value|
        queries += key.to_s << '=' << value.to_s << ((key == key_last) ? '' : '&')
        # queries += key.to_s << '=' << value.to_s << ('&' unless (key == key_last)).to_s
      end
      queries
    end
end

