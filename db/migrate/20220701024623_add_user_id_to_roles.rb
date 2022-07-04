class AddUserIdToRoles < ActiveRecord::Migration[7.0]
  def change
    add_column :roles, :user_id, :bigint
  end
end
