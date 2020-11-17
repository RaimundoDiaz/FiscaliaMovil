class CreatePoliceMen < ActiveRecord::Migration[6.0]
  def change
    create_table :police_men do |t|
      t.string :name
      t.string :rut
      t.integer :badge

      t.timestamps
    end
  end
end
