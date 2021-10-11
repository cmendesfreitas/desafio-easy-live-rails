RSpec.describe 'Passwords', type: :request do
  let(:user) { create :user }

  describe 'POST /create' do
    it 'resets password', :show_in_doc, doc_title: 'Send reset mail' do
      post api_v1_user_password_path, params: {
        email: user.email,
        redirect_url: 'http://localhost:3000/reset-password'
      }
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'PUT /update' do
    it 'updates password', :show_in_doc, doc_title: 'Password reset' do
      password_aux = Faker::Internet.password(min_length: 6, max_length: 20)
      put api_v1_user_password_path, params: {
        current_password: user.password,
        password: password_aux,
        password_confirmation: password_aux
      }, headers: user.create_new_auth_token, as: :json
      user.reload
      expect(user.valid_password?(password_aux)).to be_truthy
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end
  end
end
