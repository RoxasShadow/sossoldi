OmniAuth.config.logger = Rails.logger

keys = {
  app_id: '1422583831345052',
  secret: 'c2a05b2f79dbaf00f7a489796ff13b8e'
}

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, keys[:app_id], keys[:secret], provider_ignores_state: true, display: :popup
end

Rails.application.config.facebook = keys