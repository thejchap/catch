module Catch
  module GraphQL
    module Loaders
      class IdentityCacheLoader < ::GraphQL::Batch::Loader
        def initialize(model)
          @model = model
        end

        def perform(ids)
          if ids.length == 1
            record = @model.fetch ids.first
            fulfill record.id, record
          else
            fetch_multi ids
          end
        end

        private

        def fetch_multi(ids)
          @model.fetch_multi(ids).each do |record|
            fulfill record.id, record
          end

          ids.each do |id|
            fulfill(id, nil) unless fulfilled?(id)
          end
        end
      end
    end
  end
end
