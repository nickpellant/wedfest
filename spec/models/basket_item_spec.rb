require 'rails_helper'

RSpec.describe BasketItem, type: :model do
  it { is_expected.to belong_to(:product) }

  it { is_expected.to validate_presence_of(:product) }
  it do
    is_expected.to(
      validate_numericality_of(:quantity).is_greater_than_or_equal_to(0)
    )
  end
end
