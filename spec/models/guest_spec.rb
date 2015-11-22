require 'rails_helper'
require 'support/shoulda_matchers'

RSpec.describe Guest, type: :model do
  it { is_expected.to validate_presence_of(:invite) }
  it { is_expected.to validate_presence_of(:name) }
  it do
    is_expected.to(
      validate_inclusion_of(:attendance).in_array(Guest::ATTENDANCE_OPTIONS)
    )
  end
  it do
    is_expected.to(
      validate_inclusion_of(:diet).in_array(Guest::DIET_OPTIONS)
    )
  end

  it { is_expected.to belong_to(:invite) }

  describe '#validates_with MatchesAttendanceRestrictionValidator' do
    context 'when an evening restriction applies' do
      context 'when choosing an attendance that breaches the restriction' do
        let(:guest) do
          FactoryGirl.build(:guest, :weekend_attendance, :evening_restriction)
        end

        it 'adds an validation error to attendance' do
          expect(guest.valid?).to eq(false)
          expect(guest.errors[:attendance]).to be_present
        end
      end

      context 'when choosing an attendance that matches the restriction' do
        let(:guest) do
          FactoryGirl.build(:guest, :evening_attendance, :evening_restriction)
        end

        it 'does not add a validation error to attendance' do
          expect(guest.valid?).to eq(true)
        end
      end

      context 'when choosing not to attend' do
        let(:guest) do
          FactoryGirl.build(:guest, :not_attending, :evening_restriction)
        end

        it 'does not add a validation error to attendance' do
          expect(guest.valid?).to eq(true)
        end
      end

      context 'when attendance is still blank' do
        let(:guest) do
          FactoryGirl.build(:guest, :evening_restriction)
        end

        it 'does not add a validation error to attendance' do
          expect(guest.valid?).to eq(true)
        end
      end
    end

    context 'when no restriction applies' do
      context 'when attendance is set' do
        let(:guest) { FactoryGirl.build(:guest, :weekend_attendance) }

        it 'does not add a validation error to attendance' do
          expect(guest.valid?).to eq(true)
        end
      end

      context 'when attendance is still blank' do
        let(:guest) do
          FactoryGirl.build(:guest)
        end

        it 'does not add a validation error to attendance' do
          expect(guest.valid?).to eq(true)
        end
      end
    end
  end
end
