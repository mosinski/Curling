Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['facebook_KEY'], ENV['facebook_SECRET']
end
