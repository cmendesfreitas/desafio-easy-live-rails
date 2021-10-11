module Api::V1::RegistrationsControllerDoc
  extend Apipie::DSL::Concern

  def_param_group :authorization do
    header 'uid', 'user email', required: true
    header 'client', 'client', required: true
    header 'access-token', 'token', required: true
    error code: 401, desc: 'Unauthorized'
  end

  api :POST, '/v1/auth/', 'Signup user'
  param :name, String, required: true
  param :email, String, required: true
  param :password, String, required: true
  param :password_confirmation, String, required: true
  def create; end

  api :PUT, '/v1/auth/', 'Update user param: name or email'
  param_group :authorization
  param :name, String, required: false
  param :email, String, required: false
  def update; end

  api :DELETE, '/v1/auth/', 'Delete user'
  param_group :authorization
  def destroy; end
end
