# frozen_string_literal: true

module Catch
  module Availability
    class Update < ::Service::Base
      include Wisper.publisher

      def initialize
        super
        subscribe UpdateListener, async: true
      end

      def call(day:, range:, record:)
        if record.update(day: day, range: range)
          publish :updated, record.id
          return success(record)
        end

        failure record.errors.full_messages
      end
    end
  end
end
