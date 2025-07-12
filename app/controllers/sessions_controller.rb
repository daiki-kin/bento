class SessionsController < ApplicationController
  layout "application"

  def new
  end

  def create
    # ログイン処理
    user = User.find_by(email: params[:email])
    if user&.valid_password?(params[:password])
      sign_in(user)
      redirect_to root_path, notice: "ログインしました"
    else
      flash.now[:alert] = "メールアドレスまたはパスワードが違います"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    # ログアウト処理
    sign_out(current_user)
    redirect_to login_path, notice: "ログアウトしました"
  end
end
