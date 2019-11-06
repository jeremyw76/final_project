class CreatePackagePurchases < ActiveRecord::Migration[6.0]
  def change
    create_table :package_purchases do |t|
      t.string :description
      t.text :rules

      t.timestamps
    end
  end
end
