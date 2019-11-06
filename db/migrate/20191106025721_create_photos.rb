class CreatePhotos < ActiveRecord::Migration[6.0]
  def change
    create_table :photos do |t|
      t.string :description
      t.string :location
      t.integer :value

      t.timestamps
    end
  end
end
