# frozen_string_literal: true

module Catch
  module Availability
    class Create < ::Service::Base
      include Wisper.publisher

      def initialize
        super
        subscribe CreateListener, async: true
      end

      def call(day:, range:, user_id:)
        availability = ::Availability.new(day: day, range: range, user_id: user_id)

        if availability.save
          publish :created, availability.id
          return success(availability)
        end

        failure(availability.errors.full_messages)
      end
    end
  end
end
