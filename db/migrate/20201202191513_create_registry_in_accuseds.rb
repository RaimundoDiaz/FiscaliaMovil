class CreateRegistryInAccuseds < ActiveRecord::Migration[6.0]
  def change
    create_table :registry_in_accuseds do |t|
      t.references :accused, null: false, foreign_key: { to_table: :person_in_procedures }
      t.references :prosecutor, null: false, foreign_key: true

      t.timestamps
    end
  end
end
