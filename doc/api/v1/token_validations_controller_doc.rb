module Api::V1::TokenValidationsControllerDoc
  extend Apipie::DSL::Concern

  def_param_group :authorization do
    header 'uid', 'user email', required: true
    header 'client', 'client', required: true
    header 'access-token', 'token', required: true
    error code: 401, desc: 'Unauthorized'
  end

  api :GET, '/v1/auth/validate_token', 'Validate token'
  param_group :authorization
  def show; end
end
