module Api::V1::PasswordsControllerDoc
  extend Apipie::DSL::Concern

  def_param_group :authorization do
    header 'uid', 'email do usuário', required: true
    header 'client', 'client', required: true
    header 'access-token', 'token', required: true
    error code: 401, desc: 'Sem autorização para essa ação'
  end

  api :POST, '/v1/auth/password', 'Envia um email para mudança de senha'
  param :email, String, required: true
  def create; end

  api :PUT, '/v1/auth/password', 'Troca a senha'
  param_group :authorization
  param :current_password, String, required: true
  param :password, String, required: true
  param :password_confirmation, String, required: true
  def update; end
end
