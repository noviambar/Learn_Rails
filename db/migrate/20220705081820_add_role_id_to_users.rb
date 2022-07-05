class AddRoleIdToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :role_id, :bigint
  end
end
