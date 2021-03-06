# frozen_string_literal: true

module Catch
  module Shared
    class ServiceBase < ::Service::Base
      def self.inherited(child)
        child.define_method :wolverine do
          paths = child.name.split('::')[1..-2].map(&:underscore)
          paths.inject ::Wolverine do |memo, path|
            memo.public_send path
          end
        end
      end

      def redis
        ::Catch::Redis.redis
      end
    end
  end
end
