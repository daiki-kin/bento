class PasswordResetsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user
      @user.generate_password_reset_token!
      UserMailer.with(user: @user).password_reset.deliver_now
      redirect_to login_path, notice: "パスワードリセットのメールを送信しました"
    else
      flash.now[:alert] = "メールアドレスが見つかりません"
      render :new
    end
  end

  def edit
    @user = User.find_by(reset_password_token: params[:id])

    if @user.nil? || @user.password_reset_token_expired?
      redirect_to new_password_reset_path, alert: "リセットリンクの有効期限が切れています。再度リクエストしてください。"
    end
  end

  def update
    @user = User.find_by(reset_password_token: params[:id])

    if @user.nil? || @user.password_reset_token_expired?
      redirect_to new_password_reset_path, alert: "リセットリンクの有効期限が切れています。再度リクエストしてください。"
      return
    end

    if @user.update(password_params)
      @user.clear_password_reset_token!
      redirect_to login_path, notice: "パスワードが再設定されました"
    else
      render :edit
    end
  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
