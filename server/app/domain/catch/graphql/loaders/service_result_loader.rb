# frozen_string_literal: true

module Catch
  module GraphQL
    module Loaders
      class ServiceResultLoader < ::GraphQL::Batch::Loader
        def initialize(service)
          @service = service
        end

        def perform(args)
          args.each { |arg| fulfill arg, @service.call(arg) }
        end
      end
    end
  end
end
