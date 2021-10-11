require 'rails_helper'

RSpec.describe DeviseTokenAuth::SessionsController, type: :routing do
  describe 'routing' do
    it 'routes to #create via POST' do
      expect(post: '/api/v1/auth/sign_in').to route_to('api/v1/overrides/sessions#create')
    end

    it 'routes to #destroy via DELETE' do
      expect(delete: '/api/v1/auth/sign_out').to route_to('api/v1/overrides/sessions#destroy')
    end
  end
end
