require 'rails_helper'
require 'support/shoulda_matchers'

RSpec.describe Guest, type: :model do
  it { is_expected.to validate_presence_of(:invite) }
  it { is_expected.to validate_presence_of(:name) }
  it do
    is_expected.to(
      validate_inclusion_of(:attendance).in_array(Guest::ATTENDANCE_OPTIONS)
    )
  end
  it do
    is_expected.to(
      validate_inclusion_of(:diet).in_array(Guest::DIET_OPTIONS)
    )
  end

  it { is_expected.to belong_to(:invite) }
end
