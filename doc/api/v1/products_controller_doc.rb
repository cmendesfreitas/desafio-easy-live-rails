module Api::V1::ProductsControllerDoc
  extend Apipie::DSL::Concern

  def_param_group :authorization do
    header 'uid', 'email do usuário', required: true
    header 'client', 'client', required: true
    header 'access-token', 'token', required: true
    error code: 401, desc: 'Sem autorização para essa ação'
  end

  api :GET, '/v1/products/', 'Coleta todos os produtos válidos'
  param_group :authorization
  param :search_query, String, required: false
  param :page, String, required: false
  param :order, String, required: false
  def index; end

  api :GET, '/v1/products/:product_id', 'Coleta as informações do produto'
  param_group :authorization
  def show; end
end
