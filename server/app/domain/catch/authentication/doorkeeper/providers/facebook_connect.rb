# frozen_string_literal: true

module Catch
  module Authentication
    module Doorkeeper
      module Providers
        class FacebookConnect
          FIELDS = %w[id,email,first_name,last_name,picture].freeze

          attr_reader :assertion

          def initialize(assertion)
            @assertion = assertion
          end

          def resource_owner
            @resource_owner ||= fetch_resource_owner
          end

          private

          def fetch_resource_owner
            ::User.fetch_by_facebook_id(me[:id]) || ::User.create!(
              facebook_id: me.delete(:id),
              facebook_data: me
            )
          end

          def me
            @me ||= fb.get_object(:me, fields: FIELDS).with_indifferent_access
          end

          def fb
            @fb ||= ::Koala::Facebook::API.new assertion
          end
        end
      end
    end
  end
end
