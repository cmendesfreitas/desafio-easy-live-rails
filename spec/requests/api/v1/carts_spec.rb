require 'rails_helper'

RSpec.describe '/carts', type: :request do
  let(:user) { create :user }
  let(:product) { create :product }

  let(:valid_attributes) do
    attributes_for(:cart, product_id: product.id)
  end

  let(:invalid_attributes) do
    attributes_for(:cart, product_id: 0)
  end

  let(:valid_headers) { user.create_new_auth_token }

  let(:invalid_headers) {}

  describe 'GET index' do
    context 'no authorization token' do
      it 'return unauthorized' do
        get api_v1_carts_url, headers: invalid_headers, as: :json
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when logged in' do
      it 'renders a successful response', :show_in_doc, doc_title: 'Show cart items' do
        get api_v1_carts_url, headers: valid_headers, as: :json
        expect(response).to be_successful
      end

      it 'get 1 cart' do
        create(:cart, user_id: user.id, product_id: product.id)
        get api_v1_carts_url, headers: valid_headers, as: :json
        json_response = JSON.parse(response.body)
        expect(json_response.count).to eq(1)
      end
    end
  end

  describe 'POST create' do
    context 'no authorization token' do
      it 'return unauthorized' do
        post api_v1_carts_url, headers: invalid_headers, as: :json
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when logged in' do
      context 'with valid parameters' do
        it 'creates a new cart item', :show_in_doc, doc_title: 'Cart item added' do
          expect do
            post api_v1_carts_url,
                 params: valid_attributes, headers: valid_headers, as: :json
          end.to change(Cart, :count).by(1)
        end

        it 'renders a JSON response with the new cart item' do
          post api_v1_carts_url,
               params: valid_attributes, headers: valid_headers, as: :json
          expect(response).to have_http_status(:created)
          expect(response.content_type).to match(a_string_including('application/json'))
        end
      end

      context 'with invalid parameters' do
        it 'does not create a new cart item' do
          expect do
            post api_v1_carts_url,
                 params: { cart: invalid_attributes }, as: :json
          end.to change(Cart, :count).by(0)
        end

        it 'renders a JSON response with errors for the new cart item' do
          post api_v1_carts_url,
               params: { cart: invalid_attributes }, headers: valid_headers, as: :json
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.content_type).to eq('application/json; charset=utf-8')
        end
      end
    end
  end

  describe 'DELETE destroy' do
    let!(:cart) do
      create(:cart, user_id: user.id, product_id: product.id)
    end

    context 'no authorization token' do
      it 'return unauthorized' do
        delete api_v1_cart_url(cart.product_id), headers: invalid_headers, as: :json
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when logged in' do
      it 'destroys the requested cart item', :show_in_doc, doc_title: 'Cart item removed' do
        expect do
          delete api_v1_cart_url(cart.product_id), headers: valid_headers, as: :json
        end.to change(Cart, :count).by(-1)
      end
    end
  end
end
