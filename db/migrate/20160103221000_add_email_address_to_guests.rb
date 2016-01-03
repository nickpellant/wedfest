class AddEmailAddressToGuests < ActiveRecord::Migration
  def change
    add_column :guests, :email_address, :string
  end
end
