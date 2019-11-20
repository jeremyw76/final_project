class CreateCarts < ActiveRecord::Migration[6.0]
  def change
    create_table :carts do |t|
      t.string :session_id, null: false
      t.jsonb :items

      t.timestamps
    end
  end
end
