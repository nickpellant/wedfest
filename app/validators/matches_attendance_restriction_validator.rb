class MatchesAttendanceRestrictionValidator < ActiveModel::Validator
  def validate(record)
    @record = record

    return if attendance_restriction.blank? || attendance.blank?
    return if valid?

    record.errors.add(:attendance, :breaches_attendance_restriction)
  end

  private

  attr_reader :record
  delegate :attendance, :attendance_restriction, to: :record

  def valid?
    attendance == attendance_restriction || attendance == 'not_attending'
  end
end
