require 'csv'

class ImportInvitesCsv
  def initialize(csv_content:)
    @csv_content = csv_content
  end

  def call
    Invite.transaction do
      csv_hash.each do |row|
        row.merge!(invite_code: SecureRandom.hex(2).upcase)
        Invite.create!(row)
      end
    end
  end

  private

  attr_reader :csv_content

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
end
