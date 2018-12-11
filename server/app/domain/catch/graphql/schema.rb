module Catch
  module GraphQL
    class Schema < ::GraphQL::Schema
      mutation Types::Mutation
      query Types::QueryRoot
      use ::GraphQL::Batch

      class << self
        def id_from_object(object, _type_definition, _query_context)
          object.to_global_id.to_s
        end

        def object_from_id(gid, _query_context)
          data = GlobalID.parse gid
          return nil if data.blank?
          data.model_class.fetch data.model_id
        end

        def resolve_type(_type, object, _context)
          klass = object.class.name
          Types.const_get klass
        end
      end
    end
  end
end
