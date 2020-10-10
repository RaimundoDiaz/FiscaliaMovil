class CreateProsecutors < ActiveRecord::Migration[6.0]
  def change
    create_table :prosecutors do |t|
      t.string :name
      t.string :rut
      t.references :local_prosecutions, foreign_key: true

      t.timestamps
    end
  end
end
