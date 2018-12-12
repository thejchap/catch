# frozen_string_literal: true

module Catch
  module GraphQL
    module Types
      class User < Model
        field :email, String, null: true
        field :first_name, String, null: true
        field :last_name, String, null: true
        field :facebook_id, String, null: true
        field :picture_url, String, null: true
        field :settings, Types::Settings, null: false
        field :location, Types::Location, null: true

        def location
          return if object.settings_location.blank?

          Loaders::IdentityCacheLoader.for(::Location).load object.settings_location
        end
      end
    end
  end
end
