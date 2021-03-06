class MerchantsController < RootsController
  # layout 'welcome'
  before_action :set_menu
  skip_before_action :authenticate_user!

  def index
  end

  def create
    @merchant = api_post '/request_merchant', merchant_params
    @errors = @merchant[:message] unless @merchant[:status] == 'success'
  end

  private
    def set_menu
      session[:menu] = :merchants
    end

    def merchant_params
      params.require(:merchant).permit(:name, :email, :phone, :archive)
    end
end

