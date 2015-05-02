
class BulletinsController < ApplicationController
  before_action :set_menu
  require 'will_paginate/array'

  def index
    #get total page from api

    limit = 5
    if params[:page]
      @current_page = params[:page]
    else
      @current_page = 1
    end
    @bulletins = hash_to_object get_api('/bulletins', {:page => @current_page, :limit => limit, :condo_id => session[:condo_id], :auth_token => session[:auth_token]})
    @pages = @bulletins[:total] % limit == 0 ? @bulletins[:total]/limit : @bulletins[:total]/limit +1
    @total_bulletin = @bulletins[:total].blank? ? 0 : @bulletins[:total]
    @bulletins = @bulletins.results.blank? ? nil : @bulletins.results
  end

  def show
    bulletin = hash_to_object get_api('/bulletin_detail', {:bulletin_id => params[:id], :auth_token => session[:auth_token]})
    @bulletin = bulletin.results.blank? ? nil : bulletin.results
  end

  private
  def set_menu
    session[:menu] = :bulletins
  end
end
