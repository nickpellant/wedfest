class CreateAccommodations < ActiveRecord::Migration
  def change
    create_table :accommodations do |t|
      t.string :name, null: false
      t.integer :sleeps

      t.timestamps null: false
    end
  end
end
