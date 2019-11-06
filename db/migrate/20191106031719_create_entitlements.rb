class CreateEntitlements < ActiveRecord::Migration[6.0]
  def change
    create_table :entitlements do |t|
      t.references :customer, null: false, foreign_key: true
      t.references :photo, null: false, foreign_key: true
      t.string :hash
      t.datetime :hash_expiry
      t.integer :access_count
      t.datetime :entitlement_expiry

      t.timestamps
    end
  end
end
