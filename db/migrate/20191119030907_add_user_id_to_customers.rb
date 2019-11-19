class AddUserIdToCustomers < ActiveRecord::Migration[6.0]
  def change
    add_column :customers, :user_id, :bigint, null: false

    add_foreign_key :customers, :users
  end
end
