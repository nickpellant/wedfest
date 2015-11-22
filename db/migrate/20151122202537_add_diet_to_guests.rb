class AddDietToGuests < ActiveRecord::Migration
  def change
    add_column :guests, :diet, :string
  end
end
