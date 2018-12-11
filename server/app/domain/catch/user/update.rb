module Catch
  module User
    class Update < ::Service::Base
      def call(record:, attributes:)
        return success(record) if record.update(attributes)
        failure record.errors.full_messages
      end
    end
  end
end
