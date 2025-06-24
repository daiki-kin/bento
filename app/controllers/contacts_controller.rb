class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    ContactMailer.contact_email(
      params[:email],
      params[:subject],
      params[:message]
    ).deliver_now

    @contact = Contact.new(contact_params)
    if @contact.valid?
      # メール送信など処理
      redirect_to root_path, notice: "お問い合わせ内容を送信しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:subject, :name, :email, :message)
  end
end
