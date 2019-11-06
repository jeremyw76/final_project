class CreateTaxes < ActiveRecord::Migration[6.0]
  def change
    create_table :taxes do |t|
      t.references :line_item, null: false, foreign_key: true
      t.string :code
      t.decimal :rate, precision: 3, scale: 2
      t.integer :amount

      t.timestamps
    end
  end
end
