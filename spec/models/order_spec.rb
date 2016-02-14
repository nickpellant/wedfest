require 'rails_helper'

RSpec.describe Order, type: :model do
  it { is_expected.to belong_to(:basket) }

  it { is_expected.to have_many(:order_items) }

  it { is_expected.to validate_presence_of(:basket) }
end
