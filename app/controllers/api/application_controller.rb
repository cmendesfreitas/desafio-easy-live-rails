class Api::ApplicationController < ActionController::API
  include SkipSession
  include DeviseTokenAuth::Concerns::SetUserByToken

  before_action :skip_session
end
