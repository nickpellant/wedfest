require 'rails_helper'

RSpec.describe OrderCharge, type: :model do
  it { is_expected.to belong_to(:order) }

  it { is_expected.to validate_presence_of(:order) }
  it { is_expected.to validate_presence_of(:stripe_charge_id) }
end
