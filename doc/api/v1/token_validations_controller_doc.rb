module Api::V1::TokenValidationsControllerDoc
  extend Apipie::DSL::Concern

  def_param_group :authorization do
    header 'uid', 'email do usuário', required: true
    header 'client', 'client', required: true
    header 'access-token', 'token', required: true
    error code: 401, desc: 'Sem autorização para essa ação'
  end

  api :GET, '/v1/auth/validate_token', 'Validar uid, client e access-token'
  param_group :authorization
  def show; end
end
