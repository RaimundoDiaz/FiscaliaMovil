class CreateCrimes < ActiveRecord::Migration[6.0]
  def change
    create_table :crimes do |t|
      t.integer :crime_id
      t.string :description

      t.timestamps
    end
  end
end
