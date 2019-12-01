class RemoveEmailFromCustomers < ActiveRecord::Migration[6.0]
  def change
    remove_column :customers, :email, type: String
  end
end
