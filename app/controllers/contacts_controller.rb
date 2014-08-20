class ContactsController < RootsController
  layout 'welcome'
  before_action :set_menu
  skip_before_action :authenticate_user!

  def index
  end

  def create
    @contact = api_post '/send_contact_us', contact_params
    @errors = @contact[:message] unless @contact[:status] == 'success'
  end

  private
    def set_menu
      session[:menu] = :contacts
    end

    def contact_params
      params.require(:contact).permit(:name, :email, :phone, :message, :role)
    end
end

