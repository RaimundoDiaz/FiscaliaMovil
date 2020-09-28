class CreateLocalProsecutions < ActiveRecord::Migration[6.0]
  def change
    create_table :local_prosecutions do |t|
      t.string :name
      t.references :regional_prosecution, null: false, foreign_key: true

      t.timestamps
    end
  end
end
