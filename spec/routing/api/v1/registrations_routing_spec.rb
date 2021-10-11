require 'rails_helper'

RSpec.describe DeviseTokenAuth::RegistrationsController, type: :routing do
  describe 'routing' do
    it 'routes to #create via POST' do
      expect(post: '/api/v1/auth').to route_to('api/v1/overrides/registrations#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/api/v1/auth').to route_to('api/v1/overrides/registrations#update')
    end

    it 'routes to #destroy via DELETE' do
      expect(delete: '/api/v1/auth').to route_to('api/v1/overrides/registrations#destroy')
    end
  end
end
