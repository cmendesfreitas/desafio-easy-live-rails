require 'rails_helper'

RSpec.describe Api::V1::ProductsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/api/v1/products').to route_to('api/v1/products#index')
    end

    it 'routes to #show' do
      expect(get: '/api/v1/products/1').to route_to('api/v1/products#show', id: '1')
    end
  end
end
