# frozen_string_literal: true

module Catch
  module Availability
    module Matching
      class Listener
        class << self
          def user_updated(user_id)
            user = ::User.find user_id
            write user.settings_location
          end

          def availability_updated(availability_id)
            write location_for(availability_id)
          end

          # TODO
          def availability_deleted(availability_id)
            Rails.logger.info "Availability deleted #{availability_id}"
          end

          def availability_created(availability_id)
            write location_for(availability_id)
          end

          private

          def write(location_id)
            return if location_id.blank?
            Matching::WriterJob.perform_later location_id: location_id
          end

          def location_for(availability_id)
            availability = ::Availability.fetch availability_id
            user = ::User.fetch availability.user_id
            user.settings_location
          end
        end
      end
    end
  end
end
