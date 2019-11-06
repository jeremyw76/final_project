class CreatePackages < ActiveRecord::Migration[6.0]
  def change
    create_table :packages do |t|
      t.string :description
      t.text :rules
      t.integer :value

      t.timestamps
    end
  end
end
