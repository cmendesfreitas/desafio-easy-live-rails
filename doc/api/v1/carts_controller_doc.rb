module Api::V1::CartsControllerDoc
  extend Apipie::DSL::Concern

  def_param_group :authorization do
    header 'uid', 'user email', required: true
    header 'client', 'client', required: true
    header 'access-token', 'token', required: true
    error code: 401, desc: 'Unauthorized'
  end

  api :GET, '/v1/carts/', 'Get all valid cart items from user'
  param_group :authorization
  def index; end

  api :POST, '/v1/carts', 'Add item to cart'
  param_group :authorization
  param :product_id, String, required: true
  def create; end

  api :DELETE, '/v1/carts', 'Remove item from cart'
  param_group :authorization
  param :product_id, String, required: true
  def destroy; end
end
