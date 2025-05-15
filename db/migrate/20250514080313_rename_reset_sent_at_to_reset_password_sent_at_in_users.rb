class RenameResetSentAtToResetPasswordSentAtInUsers < ActiveRecord::Migration[7.2]
  def change
    rename_column :users, :reset_sent_at, :reset_password_sent_at
  end
end
