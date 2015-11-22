class AddAttendanceRestrictionToGuests < ActiveRecord::Migration
  def change
    add_column :guests, :attendance_restriction, :string
  end
end
