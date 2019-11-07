class AlterProvincesTableTaxRateColumnPrecisionAndScale < ActiveRecord::Migration[6.0]
  def up
    Province.connection.execute("
      ALTER TABLE provinces
      ALTER COLUMN tax_rate
      TYPE NUMERIC(6, 5)
    ");
  end

  def down
    Province.connection.execute("
      ALTER TABLE provinces
      ALTER COLUMN tax_rate
      TYPE NUMERIC(3, 2)
    ");
  end
end
