require 'rails_helper'

RSpec.describe DeviseTokenAuth::TokenValidationsController, type: :routing do
  describe 'routing' do
    it 'routes to #validate_token via GET' do
      expect(get: '/api/v1/auth/validate_token').to route_to('devise_token_auth/token_validations#validate_token')
    end
  end
end
