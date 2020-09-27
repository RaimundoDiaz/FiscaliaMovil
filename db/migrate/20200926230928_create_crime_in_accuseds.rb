class CreateCrimeInAccuseds < ActiveRecord::Migration[6.0]
  def change
    create_table :crime_in_accuseds do |t|
      t.boolean :preponderant

      t.references :crime, null: false, foreign_key: true
      t.references :person, null: false, foreign_key: true
      t.references :procedure, null: false, foreign_key: true

      t.timestamps
    end
  end
end
