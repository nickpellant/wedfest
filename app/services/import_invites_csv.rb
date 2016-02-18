require 'csv'

class ImportInvitesCsv
  def initialize(csv_content:)
    @csv_content = csv_content
  end

  def call
    Invite.transaction do
      csv_hash.each do |row|
        invite_params = {
          name: row[:invite_name],
          invite_code: SecureRandom.hex(2).upcase
        }

        invite = Invite.create!(invite_params)
        create_guests!(invite: invite, row: row)
      end
    end
  end

  private

  attr_reader :csv_content

  def create_guests!(invite:, row:)
    guest_names(row: row).each do |name|
      invite.guests.create!(
        name: name, attendance_restriction: row[:attendance_restriction]
      )
    end
  end

  def csv
    CSV::Converters[:blank_to_nil] = lambda do |field|
      field && field.empty? ? nil : field
    end
    CSV.new(
      csv_content, headers: true, header_converters: :symbol,
                   converters: [:all, :blank_to_nil]
    )
  end

  def csv_hash
    csv.to_a.map(&:to_hash)
  end

  def guest_names(row:)
    row[:guest_names].split(',').map(&:strip)
  end
end
