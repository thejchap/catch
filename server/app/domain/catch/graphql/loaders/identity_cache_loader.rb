module Catch
  module GraphQL
    module Loaders
      class IdentityCacheLoader < ::GraphQL::Batch::Loader
        def initialize(model)
          @model = model
        end

        def perform(ids)
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
