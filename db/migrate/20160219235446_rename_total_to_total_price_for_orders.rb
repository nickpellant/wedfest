class RenameTotalToTotalPriceForOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :total
    add_monetize :orders, :total_price
  end
end
