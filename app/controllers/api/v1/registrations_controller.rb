module Overrides
  class Api::V1::RegistrationsController < DeviseTokenAuth::RegistrationsController
    include SkipSession

    before_action :skip_session
  end
end
