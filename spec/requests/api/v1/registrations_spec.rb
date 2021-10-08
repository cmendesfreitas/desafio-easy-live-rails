require 'rails_helper'

RSpec.describe 'Registrations', type: :request do
  # let(:user) { create :user }
  let(:valid_attributes) do
    attributes_for(:user)
  end

  # let(:valid_headers) { user.create_new_auth_token }

  describe 'POST signup' do
    it 'user is created', :show_in_doc, doc_title: 'User signup' do
      post api_v1_user_registration_path, params: valid_attributes, as: :json
      expect(response).to have_http_status(:ok)
    end
  end

  let(:user) { create :user }

  describe 'PUT update' do
    let(:new_name) { Faker::Name.name }

    it 'updates the user' do
      put api_v1_user_registration_path,
          params: { name: new_name }, headers: user.create_new_auth_token, as: :json
      user.reload
      expect(user.name).to eq(new_name)
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the user' do
      user
      expect do
        delete api_v1_user_registration_path, headers: user.create_new_auth_token, as: :json
      end.to change(User, :count).by(-1)
    end
  end
end
