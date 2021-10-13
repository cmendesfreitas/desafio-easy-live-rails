module Api::V1::CartsControllerDoc
  extend Apipie::DSL::Concern

  def_param_group :authorization do
    header 'uid', 'email do usuário', required: true
    header 'client', 'client', required: true
    header 'access-token', 'token', required: true
    error code: 401, desc: 'Sem autorização para essa ação'
  end

  api :GET, '/v1/carts/', 'Coleta todos os items no carrinho válidos do usuário'
  param_group :authorization
  def index; end

  api :POST, '/v1/carts', 'Adiciona item ao carrinho'
  param_group :authorization
  param :product_id, String, required: true
  def create; end

  api :DELETE, '/v1/carts', 'Remove item do carrinho'
  param_group :authorization
  param :product_id, String, required: true
  def destroy; end
end
