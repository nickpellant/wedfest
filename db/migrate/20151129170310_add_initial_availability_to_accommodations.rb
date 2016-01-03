class AddInitialAvailabilityToAccommodations < ActiveRecord::Migration
  def change
    add_column :accommodations, :initial_availability, :integer
  end
end
