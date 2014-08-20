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

  private
  def set_menu
    session[:menu] = :bookings
  end
end
