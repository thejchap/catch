module Catch
  module GraphQL
    module Types
      class Model < BaseObject
        global_id_field :id
        implements ::GraphQL::Relay::Node.interface
      end
    end
  end
end
