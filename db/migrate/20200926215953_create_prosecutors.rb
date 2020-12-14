class CreateProsecutors < ActiveRecord::Migration[6.0]
  def change
    create_table :prosecutors do |t|
      t.string :name
      t.string :rut
      t.boolean :prosecutor_on_duty, default: true #if false then it is just an operator
      t.references :local_prosecution, foreign_key: true
      t.boolean :deleted, default: false

      t.timestamps
    end
  end
end
