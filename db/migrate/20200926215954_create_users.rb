class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.integer :role
      t.string :rut
      t.date :birthday
      t.references :police_unit, null: true, foreign_key: true
      t.references :local_prosecution, null: true, foreign_key: true

      t.timestamps
    end
  end
end
