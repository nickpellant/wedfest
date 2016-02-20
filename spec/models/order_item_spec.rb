require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  it { is_expected.to belong_to(:order) }
  it { is_expected.to belong_to(:product) }

  it { is_expected.to validate_presence_of(:product) }
  it { is_expected.to monetize(:sale_price) }
  it { is_expected.to monetize(:total_price) }

  it do
    is_expected.to(
      validate_numericality_of(:quantity).is_greater_than_or_equal_to(0)
    )
  end
end
