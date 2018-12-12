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
          intersecting_activities?(match) && intersecting_time?(match)
        end

        private

        def intersecting_time?(match)
          range = ::DataStructures::Range.new(*match.dig(:node, :range).split('..').map(&:to_i))
          (range & object.range).present?
        end

        def intersecting_activities?(match)
          (user.settings_activities & match[:node_activities]).any?
        end
      end
    end
  end
end
