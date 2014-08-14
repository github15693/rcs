class ContactsController < ApplicationController
  layout 'welcome'
  before_action :set_menu

  def index
    @contact = nil
  end

  def create

  end

  private
    def set_menu
      session[:menu] = :contacts
    end

    def contact_params
      params.require(:contact).permit(:name, :email, :phone, :message, :role)
    end
end

