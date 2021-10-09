require 'rails_helper'

RSpec.describe 'Products', type: :request do
  let(:user) { create :user }
  let(:valid_headers) { user.create_new_auth_token }
  let(:invalid_headers) {}

  describe 'GET index' do
    context 'no authorization token' do
      it 'return unauthorized' do
        get api_v1_products_path, headers: invalid_headers, as: :json
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when logged in' do
      it 'renders a successful response' do
        get api_v1_products_path, headers: valid_headers
        expect(response).to have_http_status(:success)
      end

      it 'get 1 product' do
        create(:product, active: true)
        get api_v1_products_path, headers: valid_headers, as: :json
        json_response = JSON.parse(response.body)
        expect(json_response.count).to eq(1)
      end
    end
  end

  describe 'GET show' do
    let!(:product) do
      create(:product)
    end

    context 'no authorization token' do
      it 'return unauthorized' do
        get api_v1_product_path(product), headers: invalid_headers, as: :json
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when logged in' do
      it 'renders a successful response' do
        get api_v1_product_path(product), headers: valid_headers
        expect(response).to have_http_status(:success)
      end
    end
  end
end
