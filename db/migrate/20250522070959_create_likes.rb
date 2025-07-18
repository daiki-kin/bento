class CreateLikes < ActiveRecord::Migration[7.2]
  def change
    create_table :likes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end

    # 二重いいね防止のためのユニーク制約
    add_index :likes, [ :user_id, :post_id ], unique: true
  end
end
