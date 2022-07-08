class AddForeignKeyComment < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :comments, :articles
  end
end
