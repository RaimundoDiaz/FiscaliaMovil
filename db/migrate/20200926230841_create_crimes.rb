class CreateCrimes < ActiveRecord::Migration[6.0]
  def change
    create_table :crimes do |t|
      t.string :name
      t.boolean :deleted, default: false

      t.timestamps
    end
  end
end
