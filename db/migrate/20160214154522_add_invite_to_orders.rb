class AddInviteToOrders < ActiveRecord::Migration
  def change
    add_reference :orders, :invite, index: true, foreign_key: true
  end
end
