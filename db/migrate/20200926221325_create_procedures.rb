class CreateProcedures < ActiveRecord::Migration[6.0]
  def change
    create_table :procedures do |t|
      t.integer :classification
      t.text :marks, array: true
      t.references :police_in_charge, null: false, foreign_key: { to_table: :police_men }
      t.references :police_unit_in_charge, null: false, foreign_key: { to_table: :police_units }
      t.references :prosecutor_in_charge, null: false, foreign_key: { to_table: :prosecutors }
      t.references :local_prosecution_in_charge, null: false, foreign_key: { to_table: :local_prosecutions }
      t.string :story
      t.string :address
      t.string :sector
      t.string :region
      t.integer :state

      t.timestamps
    end
  end
end
