class BookingsController < ApplicationController
  before_action :set_menu

  def index
    temp = hash_to_object get_api('/booking_facilities',{user_id:session[:user_id], authentication_token:session[:token]})
    @booking_facilities=temp.total > 0 ? temp.data : nil
  end

  def check_booking
    temp = hash_to_object get_api('/check_booking',{user_id:session[:user_id], authentication_token:session[:token]})
    @check_bookings=temp.total > 0 ? temp.data : nil
  end

  def show
    temp = hash_to_object get_api('/booking_detail',{booking_facility_id:params[:id], authentication_token:session[:token]})
    @booking_detail=temp.total > 0 ? temp.data : nil
  end

  def make_a_booking
    if params[:time_slot_id].nil? || params[:time_slot_id].blank?
      @message = 'Missing timeslot!'
    else
      @results = hash_to_object post_api('/make_a_booking',{user_id:session[:user_id],preferred_date:params[:preferred_date], time_slot_id:params[:time_slot_id], authentication_token:session[:token]})
      @make_a_booking=@results.total > 0 ? @results.data : nil
      @message = @results.message
    end
  end

  private
  def set_menu
    session[:menu] = :bookings
  end
end
