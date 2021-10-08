require 'rails_helper'

RSpec.describe 'Session', type: :request do
  let(:user) { create :user }
  let(:valid_headers) { user.create_new_auth_token }

  describe 'sign in' do
    context 'with valid parameters' do
      it 'should respond with success' do
        post api_v1_user_session_path, params: {
          email: user.email, password: user.password
        }, as: :json
        expect(response).to have_http_status(:success)
      end
    end

    context 'with invalid parameters' do
      it 'should respond with unauthorized' do
        post api_v1_user_session_path, params: {
          email: user.email, password: 'wrong_password'
        }, as: :json
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'sign out' do
    it 'should respond with success' do
      delete destroy_api_v1_user_session_path, headers: valid_headers
      expect(response).to have_http_status(:success)
    end
  end
end
