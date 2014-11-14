class CreatePermit < ActiveRecord::Migration
  def change
    create_table :permits do |t|
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
      t.date :effective_on
      t.string :action_type
      t.string :slant
      t.string :target_formation
      t.integer :elevation
      t.integer :depth
      t.integer :countyfips
      t.string :well_status

      t.timestamps
    end
  end
end
