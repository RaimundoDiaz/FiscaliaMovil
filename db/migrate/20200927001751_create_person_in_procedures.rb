class CreatePersonInProcedures < ActiveRecord::Migration[6.0]
  def change
    create_table :person_in_procedures do |t|
      t.references :person, null: false, foreign_key: true
      t.references :procedure, null: false, foreign_key: true
      t.integer :role

      t.timestamps
    end
  end
end
