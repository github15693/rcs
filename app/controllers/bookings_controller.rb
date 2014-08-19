class BookingsController < ApplicationController
  before_action :set_menu

  def index
    @temp = hash_to_object get_api('/booking_facilities',{user_id:session[:user_id], authentication_token:session[:token]})
    @booking_facilities=@temp.data
  end

  def check_booking
    @temp = hash_to_object get_api('/check_booking',{user_id:session[:user_id], authentication_token:session[:token]})
    @check_bookings=@temp.data
  end

  private
  def set_menu
    session[:menu] = :bookings
  end
end
