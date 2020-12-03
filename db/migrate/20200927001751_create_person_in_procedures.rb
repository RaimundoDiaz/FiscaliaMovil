class CreatePersonInProcedures < ActiveRecord::Migration[6.0]
  def change
    create_table :person_in_procedures do |t|
      t.references :person, null: false, foreign_key: true
      t.references :procedure, null: false, foreign_key: true
      t.string :witness_declaration, null:true
      t.integer :role
      t.integer :state
      t.references :prosecutor_pronounced, null: true, foreign_key: { to_table: :prosecutors }

      t.timestamps
    end
  end
end
