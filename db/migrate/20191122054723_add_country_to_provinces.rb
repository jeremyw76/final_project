class AddCountryToProvinces < ActiveRecord::Migration[6.0]
  def change
    add_column :provinces, :country, :string
  end
end
