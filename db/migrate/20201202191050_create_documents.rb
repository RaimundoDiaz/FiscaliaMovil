class CreateDocuments < ActiveRecord::Migration[6.0]
  def change
    create_table :documents do |t|
      t.string :name
      t.string :description
      t.references :procedure

      t.timestamps
    end
  end
end
