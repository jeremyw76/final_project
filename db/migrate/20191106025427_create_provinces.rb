class CreateProvinces < ActiveRecord::Migration[6.0]
  def change
    create_table :provinces do |t|
      t.string :name
      t.string :province_code
      t.decimal :tax_rate, precision: 3, scale: 2
      t.string :tax_code

      t.timestamps
    end
  end
end
