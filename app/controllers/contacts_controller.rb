class ContactsController < ApplicationController
  
  # GET request to /contact-us
  # Show new contact form
  def new
    @contact = Contact.new
  end
  
  # Post request to /contacts
  def create
    #Mass assignment of form fields into Contact Object
    # Assinging instancing variable
    @contact = Contact.new(contact_params)
    # Save contact object to the database
    if @contact.save
      # Store form fields via paramaters, into variables
      name = params[:contact][:name]
      email = params [:contact][:email]
      body = params [:contact][:comments]
      # Plug variables into Contact Mailer
      # Email method and send email
      ContactMailer.contact_email(name, email, body).deliver
      # Store success message in flash hash
      # And redirect to the new action
      flash[:success] = "Message sent."
      redirect_to new_contact_path
    else
      # If Contact Object fails to save
      # Store errors in Flash Hash
      # Redirct to the new action
      flash[:danger] = @contact.errors.full_messages.join(", ")
      redirect_to new_contact_path
    end
  end
  
  private
    # To collect data from form, we need to use strong paramaters
    # and whitelist the form fields
    def contact_params
      params.require(:contact).permit(:name, :email, :comments)
    end
end