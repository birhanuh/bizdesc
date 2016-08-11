class ContactsController < ApplicationController

  skip_before_filter :authenticate_user!

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    @contact.request = request
    if @contact.deliver
      redirect_to root_path, notice: 'Thank you for your message. We will contact you soon!'
    else
      flash[:alert] = 'Cannot send message.'
      redirect_to root_path
    end
  end

  private
  def contact_params
    params.require(:contact).permit(:name, :email, :message)
  end
end