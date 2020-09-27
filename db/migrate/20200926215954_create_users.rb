class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.integer :role
      t.string :rut
      t.date :birthday
      t.integer :id_prosecution
      t.integer :id_police_unit

      t.timestamps
    end
  end
end
