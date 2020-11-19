class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.integer :notification_type
      t.integer :reference_id
      t.boolean :seen
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
