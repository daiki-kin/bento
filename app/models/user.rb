class User < ApplicationRecord
    attr_accessor :terms_of_service, :privacy_policy

    has_many :posts, dependent: :destroy
    has_many :likes, dependent: :destroy
    has_many :liked_posts, through: :likes, source: :post

    has_one_attached :profile_image

    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
    validates :password, length: { minimum: 6 }, if: -> { password.present? }
    validates :terms_of_service, acceptance: { message: "に同意してください" }
    validates :privacy_policy, acceptance: { message: "に同意してください" }


    devise :database_authenticatable, :registerable,
            :recoverable, :validatable

    # パスワード再発行
    def generate_password_reset_token!
        update!(
            reset_password_token: SecureRandom.uuid,
            reset_password_sent_at: Time.current
        )
    end

    def clear_password_reset_token!
        update!(
        reset_password_token: nil,
        reset_password_sent_at: nil
        )
    end

    def password_reset_token_expired?
        reset_password_sent_at < 2.hours.ago
    end
end
