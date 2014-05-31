OmniAuth.config.logger = Rails.logger

keys = {
  app_id: '',
  secret: ''
}

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, keys[:app_id], keys[:secret], provider_ignores_state: true, display: :popup
end

Rails.application.config.facebook = keys