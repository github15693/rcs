class MerchantsController < ApplicationController
  layout 'welcome'
  before_action :set_menu

  def index
    @merchant = nil
  end

  def create

  end

  private
    def set_menu
      session[:menu] = :merchants
    end

    def merchant_params
      params.require(:merchant).permit(:name, :email, :phone)
    end
end

