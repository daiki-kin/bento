class UserMailer < ApplicationMailer
    def password_reset
        @user = params[:user]
        mail to: @user.email, subject: "パスワード再設定のご案内"
    end
end
