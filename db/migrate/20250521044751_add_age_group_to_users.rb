class AddAgeGroupToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :age_group, :string
  end
end
