class AddAttendanceToGuests < ActiveRecord::Migration
  def change
    add_column :guests, :attendance, :string
  end
end
