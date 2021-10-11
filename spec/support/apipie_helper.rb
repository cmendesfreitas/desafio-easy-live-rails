# frozen_string_literal: true

module ApipieRecorderPatch
  def record
    super.try(:merge, title: RSpec.current_example.metadata[:doc_title] || 'Default')
  end
end

class Apipie::Extractor::Recorder
  prepend ApipieRecorderPatch
end

RSpec.configure do |config|
  config.filter_run show_in_doc: true if ENV['APIPIE_RECORD']
end
