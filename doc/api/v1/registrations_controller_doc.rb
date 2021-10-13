module Api::V1::RegistrationsControllerDoc
  extend Apipie::DSL::Concern

  def_param_group :authorization do
    header 'uid', 'email do usuário', required: true
    header 'client', 'client', required: true
    header 'access-token', 'token', required: true
    error code: 401, desc: 'Sem autorização para essa ação'
  end

  api :POST, '/v1/auth/', 'Criar conta do usuário'
  param :name, String, required: true
  param :email, String, required: true
  param :password, String, required: true
  param :password_confirmation, String, required: true
  def create; end

  api :PUT, '/v1/auth/', 'Atualizar parâmetro do usuário: nome ou email'
  param_group :authorization
  param :name, String, required: false
  param :email, String, required: false
  def update; end

  api :DELETE, '/v1/auth/', 'Apagar conta do usuário'
  param_group :authorization
  def destroy; end
end
