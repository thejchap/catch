# frozen_string_literal: true

require 'ostruct'

module Catch
  module Authentication
    module Doorkeeper
      class ResourceOwnerFromAssertion
        PROVIDERS = {
          'facebook-connect' => Providers::FacebookConnect
        }.freeze

        class << self
          def proc
            klass = self
            @proc ||= Proc.new { klass.new(self).resource_owner }
          end
        end

        attr_reader :context
        delegate :params, to: :context

        def initialize(context)
          @context = context
        end

        def resource_owner
          @resource_owner ||= fetch_resource_owner
        end

        private

        def fetch_resource_owner
          provider = PROVIDERS[params[:provider]]
          return if provider.blank?

          provider.new(params[:assertion]).resource_owner
        end
      end
    end
  end
end
