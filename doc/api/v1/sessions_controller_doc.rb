module Api::V1::SessionsControllerDoc
  extend Apipie::DSL::Concern

  def_param_group :authorization do
    header 'uid', 'email do usuário', required: true
    header 'client', 'client', required: true
    header 'access-token', 'token', required: true
    error code: 401, desc: 'Sem autorização para essa ação'
  end

  api :POST, '/v1/auth/sign_in', 'Login do usuário'
  param :email, String, required: true
  param :password, String, required: true
  def create; end

  api :DELETE, '/v1/auth/sign_out', 'Logout do usuário'
  param_group :authorization
  def destroy; end
end
