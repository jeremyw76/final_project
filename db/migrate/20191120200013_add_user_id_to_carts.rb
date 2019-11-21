class AddUserIdToCarts < ActiveRecord::Migration[6.0]
  def change
    add_column :carts, :user_id, :bigint

    add_foreign_key :carts, :users
  end
end
