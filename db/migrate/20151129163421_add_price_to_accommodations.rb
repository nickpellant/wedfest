class AddPriceToAccommodations < ActiveRecord::Migration
  def change
    add_monetize :accommodations, :price
  end
end
