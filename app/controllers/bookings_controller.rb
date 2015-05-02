class BookingsController < ApplicationController
  before_action :set_menu

  def index

    temp = hash_to_object get_api('/booking_facilities', {user_id: session[:user_id], auth_token: session[:auth_token]})
    @booking_facilities=temp.total > 0 ? temp.results : nil

    limit = 5
    unless params[:page].blank?
      @current_page = params[:page]
    else
      @current_page = 1
    end
    @category_id = params[:category_id].blank? ? -1 : params[:category_id]
    if @category_id == -1
      facilities = hash_to_object get_api('/get_facilities', {auth_token: session[:auth_token], :condo_id => session[:condo_id], :page => @current_page})
    else
      facilities = hash_to_object get_api('/get_facilities', {auth_token: session[:auth_token], :condo_id => session[:condo_id], :facility_category => @category_id, :page => @current_page})
    end
    if facilities[:total] == 0
      @pages = 1
    else
      @pages = facilities[:total] % limit == 0 ? facilities[:total]/limit : facilities[:total]/limit + 1
    end
    @total_facility = hash_to_object(get_api('/count_facility', {auth_token: session[:auth_token], :condo_id => session[:condo_id]})).results
    @facilities = facilities.results.blank? ? nil : facilities.results
    facility_category = hash_to_object get_api('/get_facility_categories', {auth_token: session[:auth_token], :condo_id => session[:condo_id]})
    @facility_category = facility_category.status == 'success' ? facility_category.results : []
  end

  def check_booking
    session[:booking_tab] = :check_booking
    temp = hash_to_object get_api('/check_booking', {user_id: session[:user_id], auth_token: session[:auth_token]})
    @check_bookings=temp.total > 0 ? temp.results : nil
  end

  def show
    temp = hash_to_object get_api('/booking_detail', {booking_facility_id: params[:id], auth_token: session[:auth_token]})
    @booking_detail = temp.total > 0 ? temp.results : nil
  end

  def make_a_booking
    if params[:time_slot_id].nil? || params[:time_slot_id].blank?
      @message = t('booking.missing_time_slot')
    else
      @results = hash_to_object post_api('/make_a_booking', {user_id: session[:user_id], preferred_date: params[:preferred_date], time_slot_id: params[:time_slot_id], auth_token: session[:auth_token]})
      if @results.total > 0
        @make_a_booking = @results.results
        @success = true
      else
        @make_a_booking = nil
        @success = false
      end
        @message = @results.message
    end
  end

  def delete_my_booking
    post_api('/delete_my_booking', {booking_id: params[:booking_id], auth_token: session[:auth_token]})
    session[:booking_tab] = :check_booking
    @temp = hash_to_object get_api('/check_booking', {user_id: session[:user_id], auth_token: session[:auth_token]})
    @check_bookings=@temp.total > 0 ? @temp.results : nil
    @booking_loction = params[:booking_location]
  end

  private
  def set_menu
    session[:menu] = :bookings
    session[:booking_tab] = :facility_booking
  end
end
