module Catch
  module GraphQL
    module Types
      class Location < Model
        field :name, String, null: true
        field :handle, String, null: true
        field :lat, Float, null: false
        field :lng, Float, null: false
      end
    end
  end
end
