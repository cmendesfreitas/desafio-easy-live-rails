module Api
  module V1
    module Overrides
      class TokenValidationsController < DeviseTokenAuth::TokenValidationsController
        include Api::V1::TokenValidationsControllerDoc

        include SkipSession

        before_action :skip_session
      end
    end
  end
end
