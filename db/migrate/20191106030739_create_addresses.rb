class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.references :customer, null: false, foreign_key: true
      t.string :address1
      t.string :address2
      t.string :city
      t.references :province, null: false, foreign_key: true
      t.string :postal_code

      t.timestamps
    end
  end
end
