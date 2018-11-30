module Catch
  module Availability
    class Create < ::Service::Base
      def call(day:, range:)
        @availability = ::Availability.new day: day, range: range
        return success(@availability) if @availability.save
        failure(@availability.errors.full_messages)
      end
    end
  end
end
