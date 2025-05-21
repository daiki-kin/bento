class RenameNameToStoreNameInPosts < ActiveRecord::Migration[7.2]
  def change
    rename_column :posts, :name, :store_name
  end
end
