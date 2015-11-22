class Guest < ActiveRecord::Base
  ATTENDANCE_OPTIONS = %w(weekend wedding evening)

  validates :attendance,
            inclusion: { in: ATTENDANCE_OPTIONS, allow_blank: true }
  validates :invite, :name, presence: true

  belongs_to :invite
end
