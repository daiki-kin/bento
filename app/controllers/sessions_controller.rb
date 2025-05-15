class SessionsController < ApplicationController
  layout 'application'

  def new
  end

  def create
    # ログイン処理
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: 'ログインしました'
    else
      flash.now[:alert] = 'メールアドレスまたはパスワードが正しくありません'
      render :new, layout: 'application', status: :unprocessable_entity
    end
  end

  def destroy
    # ログアウト処理
    session.delete(:user_id)
    @current_user = nil
    redirect_to root_path, notice: 'ログアウトしました'
  end
end
