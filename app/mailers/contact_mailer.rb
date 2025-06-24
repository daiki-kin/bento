class ContactMailer < ApplicationMailer
    def contact_email(email, subject, message)
        @email = email
        @subject = subject
        @message = message

        mail(
            to: '01_takarajima@dgco.jp', # 管理者のメール
            from: email,
            subject: subject
        )
    end
end
