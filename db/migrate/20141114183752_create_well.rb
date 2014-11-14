class CreateWell < ActiveRecord::Migration
  def change
    create_table :wells do |t|
      t.integer :file_number
      t.integer :api_number, limit: 8
      t.string :operator_name
      t.integer :township
      t.string :township_bearing
      t.integer :range
      t.string :range_bearing
      t.integer :section
      t.string :state
      t.string :field_name
      t.date :spudded_on
      t.date :completed_on
      t.string :well_name
      t.string :well_number
      t.string :well_type
      t.string :formation
      t.string :status
      t.string :elevation
      t.integer :depth
      t.string :geom

      t.timestamps
    end
  end
end


