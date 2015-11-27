require 'rails_helper'

RSpec.describe Accommodation, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_numericality_of(:sleeps).allow_nil }
end
