class ContactsController < ApplicationController
    
    def new
      @contact = Contact.new
    end
      
    def create
      @contact = Contact.new(contact_params)
        if @contact.save
          #MAILER
          name = params[:contact][:name]
          email = params[:contact][:email]
          body = params[:contacts][:comments]
          ContactMailer.contact_email(name, email, body).deliver
          
          #REDIRECT SUCCESS
          flash[:success] = "Message sent"
          redirect_to new_contact_path
          
        else
          #REDIRECT WITH ERRORS
          flash[:danger] = @contact.errors.full_messages.join(", ")
          redirect_to new_contact_path
        end
      
    end
    
    private
      def contact_params
        params.require(:contact).permit(:name, :email, :comments)
      end

end
