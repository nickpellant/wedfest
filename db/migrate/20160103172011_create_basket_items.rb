class CreateBasketItems < ActiveRecord::Migration
  def change
    create_table :basket_items do |t|
      t.references :product, polymorphic: true, index: true, null: false
      t.integer :quantity, null: false

      t.timestamps null: false
    end
  end
end
