require 'rails_helper'
require 'support/shoulda_matchers'

RSpec.describe Guest, type: :model do
  it { is_expected.to validate_presence_of(:invite) }
  it { is_expected.to validate_presence_of(:name) }

  it { is_expected.to belong_to(:invite) }
end
