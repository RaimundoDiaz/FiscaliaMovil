class CreatePhotoInProcedures < ActiveRecord::Migration[6.0]
  def change
    create_table :photo_in_procedures do |t|
      t.references :photo_in_procedures
      t.references :procedure

      t.timestamps
    end
  end
end
