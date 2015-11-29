require 'rails_helper'

RSpec.describe AccommodationSerializer, type: :serializer do
  subject(:accommodation) { FactoryGirl.build_stubbed(:accommodation) }

  let(:actual_json) do
    ActiveModel::SerializableResource.new(accommodation).to_json
  end
  let(:expected_json) do
    {
      data: {
        id: accommodation.id.to_s,
        type: 'accommodations',
        attributes: {
          initial_availability: accommodation.initial_availability,
          name: accommodation.name,
          price_pence: accommodation.price_pence,
          sleeps: accommodation.sleeps
        }
      }
    }.to_json
  end

  it { expect(actual_json).to eql(expected_json) }
end
