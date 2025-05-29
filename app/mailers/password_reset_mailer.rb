class PasswordResetMailer < ApplicationMailer
    def reset_email
      @user = params[:user]
      @url = edit_password_reset_url(token: @user.reset_password_token)
      mail(to: @user.email, subject: "パスワード再設定のご案内")
    end
  end
