require 'rails_helper'

RSpec.describe 'Update Guest', type: :request do
  subject(:update_guest) { patch api_guest_url(id: guest_id), params }

  let(:update_attributes) do
    FactoryGirl.attributes_for(:guest, :weekend_attendance, :vegetarian)
               .slice(*%i(attendance diet email_address))
  end

  let(:params) do
    {
      data: {
        id: guest_id.to_s,
        type: 'guests',
        attributes: update_attributes
      }
    }
  end

  context 'when Guest exist' do
    let!(:guest) { FactoryGirl.create(:guest) }
    let(:guest_id) { guest.id }

    let(:updated_guest) { guest.reload }

    let(:guest_json) do
      ActiveModel::SerializableResource.new(updated_guest).to_json
    end

    before(:example) { update_guest }

    context 'when params pass validation' do
      it { expect(response.body).to eql(guest_json) }
      it { expect(response).to have_http_status(:ok) }
      it { expect(updated_guest).to have_attributes(update_attributes) }
    end

    context 'when params fail validation' do
      let(:guest_json) do
        {
          errors: [
            {
              title: I18n.translate(
                'error_codes.update_validation_failed.message'
              ),
              status: 'conflict',
              details: {
                attendance: ['is not included in the list'],
                diet: ['is not included in the list'],
                email_address: ['is invalid']
              }
            }
          ]
        }.to_json
      end

      let(:update_attributes) do
        { attendance: 'invalid', diet: 'invalid', email_address: 'invalid' }
      end

      it { expect(response.body).to eql(guest_json) }
      it { expect(response).to have_http_status(:conflict) }
      it { expect(updated_guest).to_not have_attributes(update_attributes) }
    end
  end

  context 'when Guest not found' do
    let(:guest_id) { 1 }

    let(:guest_json) do
      {
        errors: [
          {
            title: I18n.translate('error_codes.update_not_found.message'),
            status: 'not_found'
          }
        ]
      }.to_json
    end

    before(:example) { update_guest }

    it { expect(response.body).to eql(guest_json) }
    it { expect(response).to have_http_status(:not_found) }
  end
end
