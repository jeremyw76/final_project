class AddAddressToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :address_id, :bigint, null: false

    add_foreign_key :orders, :addresses
  end
end
