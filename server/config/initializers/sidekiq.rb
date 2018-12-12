Sidekiq.configure_server do |config|
  config.average_scheduled_poll_interval = 2
  config.redis = Catch::Redis.redis
end

Sidekiq.configure_client do |config|
  config.redis = Catch::Redis.redis
end
