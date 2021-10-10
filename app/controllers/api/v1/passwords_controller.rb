module Overrides
  class Api::V1::PasswordsController < DeviseTokenAuth::PasswordsController
    include SkipSession

    before_action :skip_session
  end
end
