module Catch
  module GraphQL
    module Loaders
      class IdentityCacheAssociationLoader < ::GraphQL::Batch::Loader
        def self.validate(model, association_name)
          new(model, association_name)
          nil
        end

        def initialize(model, association_name)
          @model = model
          @data = {}
          @association_name = association_name
          validate
        end

        def load(id)
          return Promise.resolve(read_association(id)) if association_loaded?(id)
          super
        end

        def cache_key(record)
          record.object_id
        end

        def perform(records)
          preload_association(records)
          records.each { |record| fulfill(record, read_association(record)) }
        end

        private

        def validate
          unless @model.reflect_on_association(@association_name)
            raise ArgumentError, "No association #{@association_name} on #{@model}"
          end
        end

        def preload_association(records)
          @data = records.uniq.each_with_object({}) do |id, obj|
            obj[id] = ::Availability.fetch_by_user_id(id)
          end
        end

        def read_association(record)
          @data[record]
        end

        def association_loaded?(record)
          @data.key? record
        end
      end
    end
  end
end
