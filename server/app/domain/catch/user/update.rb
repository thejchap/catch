module Catch
  module User
    class Update < ::Service::Base
      def call(record:, settings_activities:)
        return success(record) if record.update(
          settings_activities: settings_activities,
        )

        failure record.errors.full_messages
      end
    end
  end
end
