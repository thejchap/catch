# frozen_string_literal: true

module Catch
  module User
    class UpdateListener
      class << self
        def updated(user_id)
          services[:matching].user_updated user_id
        end

        private

        def services
          {
            matching: ::Catch::Availability::Matching::Listener
          }
        end
      end
    end
  end
end
