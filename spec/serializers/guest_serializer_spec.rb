require 'rails_helper'

RSpec.describe GuestSerializer, type: :serializer do
  subject(:guest) do
    FactoryGirl.build_stubbed(:guest, :weekend_attendance, :vegetarian)
  end
  let(:invite) { guest.invite }

  let(:actual_json) { ActiveModel::SerializableResource.new(guest).to_json }
  let(:expected_json) do
    {
      data: {
        id: guest.id.to_s,
        type: 'guests',
        attributes: {
          attendance: guest.attendance,
          attendance_restriction: guest.attendance_restriction,
          diet: guest.diet,
          name: guest.name
        },
        relationships: {
          invite: {
            data: {
              id: invite.id.to_s,
              type: 'invites'
            }
          }
        }
      }
    }.to_json
  end

  it { expect(actual_json).to eql(expected_json) }
end
