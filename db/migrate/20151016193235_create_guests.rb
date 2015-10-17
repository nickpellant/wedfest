class CreateGuests < ActiveRecord::Migration
  def change
    create_table :guests do |t|
      t.string :name, null: false
      t.references :invite, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
