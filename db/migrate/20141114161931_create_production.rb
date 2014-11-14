class CreateProduction < ActiveRecord::Migration
  def change
    create_table :productions do |t|
      t.integer :api_number, limit: 8
      t.date :reported_on
      t.decimal :barrels_oil
      t.decimal :mcf_gas
      t.decimal :barrels_water
      t.integer :days_producing

      t.timestamps
    end
  end
end

