class Migrate < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :roles, :users
  end
end
