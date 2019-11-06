class CreatePaymentMethods < ActiveRecord::Migration[6.0]
  def change
    create_table :payment_methods do |t|
      t.references :customer, null: true, foreign_key: true
      t.string :payment_token
      t.string :card_type

      t.timestamps
    end
  end
end
