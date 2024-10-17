require 'sidekiq'
require 'sidekiq/api'

Sidekiq.configure_server do |config|
  config.redis = { 
    url: ENV['REDIS_URL'] || 'redis://localhost:6379/0'
  }

  # Middleware, error handling, etc. can be configured here
end

Sidekiq.configure_client do |config|
  config.redis = { 
    url: ENV['REDIS_URL'] || 'redis://localhost:6379/0'
  }
end
