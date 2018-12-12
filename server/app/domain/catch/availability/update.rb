# frozen_string_literal: true

module Catch
  module Availability
    class Update < ::Service::Base
      def call(day:, range:, record:)
        return success(record) if record.update(
          day: day,
          range: range
        )

        failure record.errors.full_messages
      end
    end
  end
end
