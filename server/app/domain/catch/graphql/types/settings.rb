module Catch
  module GraphQL
    module Types
      class Settings < BaseObject
        field :activities_bouldering, Boolean, null: false
        field :activities_lead, Boolean, null: false
        field :activities_top_rope, Boolean, null: false
        field :activities_workout, Boolean, null: false
        field :location, String, null: true

        def activities_bouldering
          object.fetch 'activities.bouldering', false
        end

        def activities_lead
          object.fetch 'activities.lead', false
        end

        def activities_top_rope
          object.fetch 'activities.top_rope', false
        end

        def activities_workout
          object.fetch 'activities.workout', false
        end
      end
    end
  end
end
