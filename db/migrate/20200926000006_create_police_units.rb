class CreatePoliceUnits < ActiveRecord::Migration[6.0]
  def change
    create_table :police_units do |t|
      t.string :name
      t.references :police_station, null: false, foreign_key: true

      t.timestamps
    end
  end
end
