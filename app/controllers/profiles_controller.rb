class ProfilesController < ApplicationController
  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      respond_to do |format|
        format.turbo_stream { render partial: "shared/redirect", locals: { url: user_path(@user) } }
        format.html { redirect_to user_path(@user), notice: "プロフィールを更新しました" }
      end
    else
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("profile_form", partial: "profiles/form", locals: { user: @user }) }
        format.html { render :edit }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :gender, :age_group, :profile_image, :password, :password_confirmation)
  end
end
