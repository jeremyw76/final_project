class CreatePayments < ActiveRecord::Migration[6.0]
  def change
    create_table :payments do |t|
      t.references :payment_method, null: false, foreign_key: true
      t.references :order, null: false, foreign_key: true
      t.integer :amount

      t.timestamps
    end
  end
end
