IdentityCache.cache_backend = ActiveSupport::Cache.lookup_store(*Rails.configuration.cache_store)
