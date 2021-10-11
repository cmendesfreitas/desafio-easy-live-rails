module Api::V1::SessionsControllerDoc
  extend Apipie::DSL::Concern

  def_param_group :authorization do
    header 'uid', 'user email', required: true
    header 'client', 'client', required: true
    header 'access-token', 'token', required: true
    error code: 401, desc: 'Unauthorized'
  end

  api :POST, '/v1/auth/sign_in', 'Login user'
  param :email, String, required: true
  param :password, String, required: true
  def create; end

  api :DELETE, '/v1/auth/sign_out', 'Logout user'
  param_group :authorization
  def destroy; end
end
