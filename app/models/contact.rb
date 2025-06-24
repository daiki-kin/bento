class Contact
    include ActiveModel::Model
    attr_accessor :subject, :name, :email, :message

    validates :subject, :name, :email, :message, presence: true
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
