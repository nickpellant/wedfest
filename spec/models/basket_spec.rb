require 'rails_helper'

RSpec.describe Basket, type: :model do
  it { is_expected.to belong_to(:invite) }

  it { is_expected.to validate_presence_of(:invite) }
end
