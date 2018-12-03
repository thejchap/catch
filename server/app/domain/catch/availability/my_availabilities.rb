module Catch
  module Availability
    class MyAvailabilities < ::Service::Base
      def call(user:)
        ::Availability.fetch_by_user_id user.id
      end
    end
  end
end
