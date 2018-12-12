# frozen_string_literal: true

require 'logger'

module Service
  class Base
    unless defined?(Result)
      Result = Struct.new :success, :value do
        def success?
          success
        end

        def failure?
          !success
        end
      end
    end

    class << self
      def call(*args)
        new.call(*args)
      end
    end

    def success(value)
      Result.new true, value
    end

    def failure(value)
      Result.new false, value
    end

    def logger
      @logger ||= defined?(Rails) ? Rails.logger : ::Logger.new(STDOUT)
    end
  end
end
