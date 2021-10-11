module Api::V1::ProductsControllerDoc
  extend Apipie::DSL::Concern

  def_param_group :authorization do
    header 'uid', 'user email', required: true
    header 'client', 'client', required: true
    header 'access-token', 'token', required: true
    error code: 401, desc: 'Unauthorized'
  end

  api :GET, '/v1/products/', 'Get all valid products'
  param_group :authorization
  def index; end

  api :GET, '/v1/products/:product_id', 'Get product details'
  param_group :authorization
  def show; end
end
