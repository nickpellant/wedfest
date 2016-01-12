class CreateBaskets < ActiveRecord::Migration
  def change
    create_table :baskets do |t|
      t.references :invite, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
