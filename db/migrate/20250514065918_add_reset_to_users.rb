class AddResetToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :reset_password_token, :string
    add_column :users, :reset_sent_at, :datetime
  end
end
