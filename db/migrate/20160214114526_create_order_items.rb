class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.references :order, index: true, null: false
      t.references :product, polymorphic: true, index: true, null: false
      t.money :sale_price, null: false
      t.integer :quantity, null: false

      t.timestamps null: false
    end
  end
end
