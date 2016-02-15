class AddDescriptionToAccommodations < ActiveRecord::Migration
  def change
    add_column :accommodations, :description, :text
  end
end
