# frozen_string_literal: true

module Catch
  class Redis
    class << self
      def redis
        @redis ||= ::Redis.new(opts)
      end

      private

      def opts
        Rails.application.config.redis
      end
    end
  end
end
