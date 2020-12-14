class CreateRegionalProsecutions < ActiveRecord::Migration[6.0]
  def change
    create_table :regional_prosecutions do |t|
      t.string :name
      t.integer :region
      t.boolean :deleted, default: false

      t.timestamps
    end
  end
end
