module ApplicationHelper

  def hash_to_object hash
    begin
      return Hashie::Mash.new hash
    rescue
      return nil
    end
  end

  def string_to_hash string
    return hash_to_object eval(string.to_s)
  end

  def image_base_url
    return 'http://rms.innoria.com'
  end


 API_BASE_URL = "http://rms.innoria.com/api"

def url
 "http://rms.innoria.com" 
end


  def get_api url, parameters=nil, username_api=nil, password_api=nil
    begin
    if !url.nil? && !parameters.nil? && (username_api.nil? || password_api.nil?)
      param = '?'
      i=0
      parameters.each do |key, val|
        param += "#{key}=#{val}"
        i+=1
        if i < parameters.size
          param += '&'
        end
      end
      uri = "#{API_BASE_URL}#{url}#{param}"
      rest_resource = RestClient::Resource.new(uri, username_api, password_api)
      return JSON.parse(rest_resource.get, :symbolize_names => true)
    elsif !url.nil? && parameters.nil? && (username_api.nil? || password_api.nil?)
      uri = "#{API_BASE_URL}#{url}"
      rest_resource = RestClient::Resource.new(uri)
      return JSON.parse(rest_resource.get, :symbolize_names => true)
    elsif !url.nil? && !parameters.nil? && !username_api.nil? && !password_api.nil?
      param = '?'
      i=0
      parameters.each do |key, val|
        param += "#{key}=#{val}"
        i+=1
        if i < parameters.size
          param += '&'
        end
      end
      uri = "#{API_BASE_URL}#{url}#{param}"
      rest_resource = RestClient::Resource.new(uri, username_api, password_api)
      return JSON.parse(rest_resource.get, :symbolize_names => true)
    elsif !url.nil? && parameters.nil? && !username_api.nil? && !password_api.nil?
      uri = "#{API_BASE_URL}#{url}"
      rest_resource = RestClient::Resource.new(uri, username_api, password_api)
      return JSON.parse(rest_resource.get, :symbolize_names => true)
    else
      return  {status:'failed', message:'Get api error', total:0, data:nil}
    end
    rescue
      return {status:'failed', message:'Get api error', total:0, data:nil}
    end
  end

  def post_api url, parameters, username_api=nil, password_api=nil
    uri = "#{API_BASE_URL}#{url}"
    rest_resource = RestClient::Resource.new(uri, username_api, password_api)
    begin
      return JSON.parse(rest_resource.post(parameters, :content_type=> 'application/json'), :symbolize_names => true)
    rescue
      return {status:'failed', message:'Post api error', total:0, data:nil}
    end
  end

  def currency(val)
    "#{ActionController::Base.helpers.number_to_currency(val)}"
  end


  def number_format number = 0
    txt = number.to_i.to_s
    rs = ''
    for s in 0...txt.size do
      rs += txt[txt.size - s - 1]; rs += ',' if (s+1)%3 == 0 && s+1 > 1 && s+1 != txt.size
    end
    return session[:language] == 'vi' || session[:language].nil? ? rs.reverse! + ' đồng' : rs.reverse!
  end

end

