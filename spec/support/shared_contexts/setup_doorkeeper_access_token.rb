RSpec.shared_context 'setup_doorkeeper_access_token' do
  let(:doorkeeper_access_token) do
    FactoryGirl.create(
      :doorkeeper_access_token, resource_owner_id: doorkeeper_invite.id
    )
  end

  let(:current_invite) { FactoryGirl.create(:invite) }
  let(:doorkeeper_invite) { current_invite }

  before(:example) do
    params&.merge!(access_token: doorkeeper_access_token.token)
  end
end
