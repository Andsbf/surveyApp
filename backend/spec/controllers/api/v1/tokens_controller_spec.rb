RSpec.describe Api::V1::TokensController, type: :controller do
  let(:application) { Fabricate(:api_application) }
  let(:merchant_params) { { id: rand(1..1000).to_s } }

  describe 'POST #issue_merchant_token' do
    before :each do
      params = {
        application: {
          app_id: application.app_id,
          app_secret: application.app_secret
        },
        merchant: merchant_params
      }

      post :issue_merchant_token, params
    end

    it 'is a success' do
      expect(response).to be_success
    end

    it 'includes the token in the reponse' do
      expect(JSON.parse(response.body).include?("token")).to be true
    end

    it 'creates a merchant' do
      expect(Merchant.count).to eq(1)
    end

    it 'should not allow unauthorized applications to generate tokens' do
      params = {
        application: { app_id: "paper", app_secret: application.app_secret},
        merchant: merchant_params
      }
      post :issue_merchant_token, params

      expect(response).to have_http_status(401)
    end
  end
end
