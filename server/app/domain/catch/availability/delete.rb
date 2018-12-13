# frozen_string_literal: true

module Catch
  module Availability
    class Delete < ::Service::Base
      include Wisper.publisher

      def initialize
        super
        subscribe DeleteListener, async: true
      end

      def call(record:)
        if record.destroy
          publish :destroyed, record.id
          return success(nil)
        end

        failure record.errors.full_messages
      end
    end
  end
end
