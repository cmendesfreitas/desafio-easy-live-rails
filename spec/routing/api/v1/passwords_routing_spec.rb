require 'rails_helper'

RSpec.describe DeviseTokenAuth::PasswordsController, type: :routing do
  describe 'routing' do
    it 'routes to #create via POST' do
      expect(post: '/api/v1/auth/password').to route_to('api/v1/overrides/passwords#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/api/v1/auth/password').to route_to('api/v1/overrides/passwords#update')
    end
  end
end
