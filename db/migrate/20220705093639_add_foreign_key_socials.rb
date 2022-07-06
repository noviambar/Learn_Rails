class AddForeignKeySocials < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :socials, :users
  end
end
