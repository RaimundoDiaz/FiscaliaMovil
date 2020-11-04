class CreatePeople < ActiveRecord::Migration[6.0]
  def change
    create_table :people do |t|
      t.string :name
      t.string :last_name
      t.date :birthday
      t.string :rut, optional: true
      t.boolean :deceased

      t.timestamps
    end
  end
end
