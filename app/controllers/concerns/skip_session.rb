# app/models/concerns/skip_session.rb

module SkipSession
  extend ActiveSupport::Concern

  protected

  def skip_session
    request.session_options[:skip] = true
  end
end
