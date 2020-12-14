class CreateVideos < ActiveRecord::Migration[6.0]
  def change
    create_table :videos do |t|
      t.string :description
      t.references :procedure

      t.timestamps
    end
  end
end
