class CreateLineItems < ActiveRecord::Migration[6.0]
  def change
    create_table :line_items do |t|
      t.references :order, null: false, foreign_key: true
      t.references :item, polymorphic: true, null: false
      t.integer :quantity
      t.integer :value
      t.boolean :taxable

      t.timestamps
    end
  end
end
