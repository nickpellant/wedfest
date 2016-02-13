require 'rails_helper'

RSpec.describe BasketItem, type: :model do
  describe 'validations' do
    subject(:basket_item) { FactoryGirl.build(:basket_item) }

    it { is_expected.to belong_to(:basket) }
    it { is_expected.to belong_to(:product) }

    it { is_expected.to validate_presence_of(:basket) }
    it { is_expected.to validate_presence_of(:product) }
    it do
      is_expected.to(
        validate_numericality_of(:quantity).is_greater_than_or_equal_to(0)
      )
    end
  end
end
