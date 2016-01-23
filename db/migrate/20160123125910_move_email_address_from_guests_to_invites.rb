class MoveEmailAddressFromGuestsToInvites < ActiveRecord::Migration
  def change
    remove_column :guests, :email_address
    add_column :invites, :email_address, :string
  end
end
