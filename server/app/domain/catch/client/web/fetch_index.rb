module Catch
  module Client
    module Web
      class FetchIndex < ::Service::Base
        PREFIX = 'catch:web:ember:build:index'.freeze
        CURRENT = "#{PREFIX}:current".freeze

        def call
          success index
        end

        private

        def index
          get "#{PREFIX}:#{get(CURRENT)}"
        end

        def get(*args)
          ::Catch::Redis.redis.get(*args)
        end
      end
    end
  end
end
