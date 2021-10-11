module Api::V1::PasswordsControllerDoc
  extend Apipie::DSL::Concern

  def_param_group :authorization do
    header 'uid', 'user email', required: true
    header 'client', 'client', required: true
    header 'access-token', 'token', required: true
    error code: 401, desc: 'Unauthorized'
  end

  api :POST, '/v1/auth/password', 'Send a password reset confirmation email'
  param :email, String, required: true
  param :redirect_url, String, required: true
  def create; end

  api :PUT, '/v1/auth/password', 'Password reset'
  param_group :authorization
  param :current_password, String, required: true
  param :password, String, required: true
  param :password_confirmation, String, required: true
  def update; end
end
