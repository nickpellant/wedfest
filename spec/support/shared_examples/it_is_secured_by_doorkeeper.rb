RSpec.shared_examples 'it is secured by doorkeeper' do
  let(:request_method) {}
  let(:request_url) {}
  let(:request_params) { {} }

  let(:perform_request) { send(request_method, request_url, request_params) }

  context 'when request is not authorized' do
    before(:example) { perform_request }

    it { expect(response).to have_http_status(:unauthorized) }
  end
end
