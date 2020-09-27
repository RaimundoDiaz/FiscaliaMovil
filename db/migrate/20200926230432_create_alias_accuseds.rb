class CreateAliasAccuseds < ActiveRecord::Migration[6.0]
  def change
    create_table :alias_accuseds do |t|
      t.string :alias
      t.references :person, null: false, foreign_key: true

      t.timestamps
    end
  end
end
