# frozen_string_literal: true

module Catch
  module Availability
    module Matching
      class MatchFilterPolicy
        attr_reader :object, :user, :graph

        def initialize(object, user, graph)
          @object = object
          @user = user
          @graph = graph
        end

        def valid?(match)
          intersecting_activities?(match) && !stale?
        end

        private

        def intersecting_activities?(match)
          (user.settings_activities & match[:node_activities]).any?
        end

        def stale?
          graph.updated_at < object.updated_at
        end
      end
    end
  end
end
