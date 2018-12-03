module Catch
  module Availability
    class Create < ::Service::Base
      def call(day:, range:, user_id:)
        @availability = ::Availability.new(
          day:      day,
          range:    range,
          user_id:  user_id
        )

        return success(@availability) if @availability.save
        failure(@availability.errors.full_messages)
      end
    end
  end
end
