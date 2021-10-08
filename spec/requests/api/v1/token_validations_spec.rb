require 'rails_helper'

RSpec.describe 'Token Validations', type: :request do
  describe 'signed in' do
    let(:user) { create :user }
    let(:valid_headers) { user.create_new_auth_token }

    it 'should respond with success' do
      get api_v1_auth_validate_token_path, headers: valid_headers
      expect(response).to have_http_status(:success)
    end
  end

  describe 'signed out' do
    it 'should respond with unauthorized' do
      get api_v1_auth_validate_token_path, headers: {}
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
