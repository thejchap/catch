module Catch
  module Authentication
    module Doorkeeper
      module Providers
        class FacebookConnect
          FIELDS = %w[id,email,first_name,last_name].freeze

          attr_reader :assertion

          def initialize(assertion)
            @assertion = assertion
          end

          def resource_owner
            @resource_owner ||= User.where(
              facebook_id: me[:id]
            ).first_or_create! do |user|
              user.assign_attributes(
                facebook_id:    me[:id],
                facebook_data:  me
              )
            end
          end

          private

          def me
            @me ||= fb.get_object(:me, fields: FIELDS).with_indifferent_access
          end

          def fb
            @fb ||= Koala::Facebook::API.new assertion
          end
        end
      end
    end
  end
end
