require 'rails_helper'
require 'support/shoulda-matchers'

RSpec.describe Invite, type: :model do
  it { is_expected.to validate_presence_of(:invite_code) }
  it { is_expected.to validate_uniqueness_of(:invite_code).case_insensitive }
end
