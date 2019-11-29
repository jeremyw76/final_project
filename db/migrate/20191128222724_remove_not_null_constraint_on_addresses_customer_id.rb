class RemoveNotNullConstraintOnAddressesCustomerId < ActiveRecord::Migration[6.0]
  def change
    change_column :addresses, :customer_id, :bigint, null: true
  end
end
