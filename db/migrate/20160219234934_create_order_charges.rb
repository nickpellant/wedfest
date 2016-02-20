class CreateOrderCharges < ActiveRecord::Migration
  def change
    create_table :order_charges do |t|
      t.string :stripe_charge_id
      t.references :order, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
