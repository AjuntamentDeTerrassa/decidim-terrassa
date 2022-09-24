# frozen_string_literal: true

require "sidekiq/web"

redis_database = { url: ENV.fetch("REDIS_URL") }

Sidekiq.configure_server do |config|
  config.redis = redis_database
end

Sidekiq.configure_client do |config|
  config.redis = redis_database
end
