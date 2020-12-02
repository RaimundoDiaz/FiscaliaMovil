class CreateOperators < ActiveRecord::Migration[6.0]
  def change
    create_table :operators do |t|
      t.string :name
      t.string :rut
      t.references :prosecutor, null: false, foreign_key: true
      t.boolean :deleted, default: false

      t.timestamps
    end
  end
end
