require 'rails_helper'

RSpec.describe Accommodation, type: :model do
  it do
    is_expected.to(
      validate_numericality_of(:initial_availability)
      .allow_nil
      .is_greater_than_or_equal_to(0)
    )
  end
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:name).case_insensitive }
  it { is_expected.to validate_numericality_of(:sleeps).allow_nil }
  it { is_expected.to monetize(:price) }
end
