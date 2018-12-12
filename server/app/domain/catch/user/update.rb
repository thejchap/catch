# frozen_string_literal: true

module Catch
  module User
    class Update < ::Service::Base
      include Wisper.publisher

      def initialize
        super
        subscribe UpdateListener, async: true
      end

      def call(record:, attributes:)
        if record.update(attributes)
          publish :updated, record.id
          return success(record)
        end

        failure record.errors.full_messages
      end
    end
  end
end
