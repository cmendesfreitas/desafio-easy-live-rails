require 'rails_helper'

RSpec.describe Api::V1::CartsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/api/v1/carts').to route_to('api/v1/carts#index')
    end

    it 'routes to #create' do
      expect(post: '/api/v1/carts').to route_to('api/v1/carts#create')
    end

    it 'routes to #destroy' do
      expect(delete: '/api/v1/carts/1').to route_to('api/v1/carts#destroy', id: '1')
    end
  end
end
