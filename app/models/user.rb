class User < ApplicationRecord
    has_secure_password

    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
    validates :password, length: { minimum: 6 }, if: -> { password.present? }

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
