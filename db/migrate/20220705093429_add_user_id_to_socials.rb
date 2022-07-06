class AddUserIdToSocials < ActiveRecord::Migration[7.0]
  def change
    add_column :socials, :user_id, :bigint
  end
end
