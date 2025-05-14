class User < ApplicationRecord
    has_secure_password

    variants :name, presence: true
    validates :email, presence: true, uniqueness: true
end
