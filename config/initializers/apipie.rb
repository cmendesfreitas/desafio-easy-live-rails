Apipie.configure do |config|
  config.app_name                = 'Desafio Easy Live Rails'
  config.api_base_url            = '/api'
  config.doc_base_url            = '/apipie'
  config.app_info                = 'Veja as rotas disponíveis'
  # where is your API defined?
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/api/**/*.rb"
  
  config.default_locale = 'pt-BR'
  config.languages = %w[en pt-BR]
  # config.translate = false
end
