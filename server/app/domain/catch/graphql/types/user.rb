module Catch
  module GraphQL
    module Types
      class User < Model
        field :email, String, null: true
        field :first_name, String, null: true
        field :last_name, String, null: true
        field :facebook_id, String, null: true
      end
    end
  end
end
