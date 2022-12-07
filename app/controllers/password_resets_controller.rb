class PasswordResetsController < ApplicationController
    def new
    
    end

    def create
     @user= User.find_by(email: params[:email])

     if @user.present?
        #send email
        PasswordMailer.with(user: @user).reset.deliver_now
        redirect_to root_path, notice: "If the email is registered, you will receive a reset link shortly."
     else
        redirect_to root_path, notice: "If the email is registered, you will receive a reset link shortly."
     end

    end

    def edit
      @user = User.find_signed!(params[:token], purpose: "password_reset")
    rescue
      redirect_to sign_in_path, alert: "your token has expired. Please try again."
      
    end

    def update
      @user = User.find_signed!(params[:token], purpose: "password_reset")
      if @user.update(password_params)
         redirect_to sign_in_path, notice: "Your password was reset successfully. Please sign in"
      else
         render :edit , alert:"Something was wrong. Please try again"
      end
   end

    private
    
    def password_params
      params.require(:user).permit( :password, :password_confirmation)
    end



end