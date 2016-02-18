require 'rails_helper'
require 'support/shoulda_matchers'

RSpec.describe Invite, type: :model do
  describe 'validations' do
    subject(:invite) { FactoryGirl.build(:invite) }

    it { is_expected.to allow_value(nil).for(:email_address) }
    it { is_expected.to allow_value('john@example.com').for(:email_address) }
    it do
      is_expected.to_not allow_value('invalidexample.com').for(:email_address)
    end

    it { is_expected.to validate_presence_of(:invite_code) }
    it { is_expected.to validate_uniqueness_of(:invite_code).case_insensitive }

    it { is_expected.to validate_presence_of(:name) }

    it { is_expected.to have_many(:guests) }
    it { is_expected.to have_many(:baskets) }
  end
end
