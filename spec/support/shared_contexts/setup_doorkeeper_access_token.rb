RSpec.shared_context 'setup_doorkeeper_access_token' do
  let(:doorkeeper_access_token) do
    FactoryGirl.create(
      :doorkeeper_access_token, resource_owner_id: doorkeeper_guest.id
    )
  end

  let(:current_guest) { FactoryGirl.create(:guest) }
  let(:doorkeeper_guest) { current_guest }

  before(:example) do
    params&.merge!(access_token: doorkeeper_access_token.token)
  end
end
