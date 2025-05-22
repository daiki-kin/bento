class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  # 二重いいね防止
  validates :user_id, uniqueness: { scope: :post_id }
end
