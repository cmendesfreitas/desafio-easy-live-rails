require 'rails_helper'

RSpec.describe 'Products', search: true, type: :request do
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
      let!(:product) do
        create(:product, active: true)
      end

      it 'renders a successful response' do
        get api_v1_products_path, headers: valid_headers
        expect(response).to have_http_status(:success)
      end

      it 'get 1 product', :show_in_doc, doc_title: 'get all products' do
        Product.search_index.refresh
        get api_v1_products_path, headers: valid_headers, as: :json
        json_response = JSON.parse(response.body)
        expect(json_response['products'].count).to eq(1)
      end

      it "searches" do
        store = create(:store)
        Product.create!(attributes_for(:product, store_id: store.id, name: "Apple"))
        Product.search_index.refresh
        assert_equal ["Apple"], Product.search("apple").map(&:name)
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
      it 'renders a successful response', :show_in_doc, doc_title: 'get 1 products' do
        get api_v1_product_path(product), headers: valid_headers
        expect(response).to have_http_status(:success)
      end
    end
  end
end
