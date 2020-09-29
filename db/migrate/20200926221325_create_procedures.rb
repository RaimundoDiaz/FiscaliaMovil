class CreateProcedures < ActiveRecord::Migration[6.0]
  def change
    create_table :procedures do |t|
      t.integer :classification
      t.text :categories, array: true
      t.references :police_in_charge, null: false, foreign_key: { to_table: :users }
      t.references :local_prosecution, null: false, foreign_key: true
      t.string :story
      t.string :address
      t.integer :state

      t.timestamps
    end
  end
end
