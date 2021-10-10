class Api::ApplicationController < ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken
end
