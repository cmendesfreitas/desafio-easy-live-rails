module Overrides
  class Api::V1::TokenValidationsController < DeviseTokenAuth::TokenValidationsController
    include SkipSession

    before_action :skip_session
  end
end
