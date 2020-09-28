class CreatePoliceStations < ActiveRecord::Migration[6.0]
  def change
    create_table :police_stations do |t|
      t.string :name
      t.integer :police_type
      t.references :prefecture, null: false, foreign_key: true

      t.timestamps
    end
  end
end
