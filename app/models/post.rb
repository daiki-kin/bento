class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :post_image

  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  validates :store_name, :review, :rating, presence: true
  validates :rating, inclusion: { in: 1..5 }

  # 位置情報のバリデーション（必要であれば）
  validates :latitude, :longitude, numericality: true, allow_nil: true

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
