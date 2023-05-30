class UserMailer < ApplicationMailer
    def password_reset
        @user = params[:user]
    
        mail(to: @user.email, subject: "Reset Password")
      end
end
