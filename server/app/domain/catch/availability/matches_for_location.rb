module Catch
  module Availability
    class MatchesForLocation < ::Service::Base
      class AvailabilityMatch
        attr_reader :node, :parent, :jaccard, :rank, :day, :activities_intersection

        def initialize(node:, parent:, jaccard:, rank:, activities_intersection:)
          @node = node
          @parent = parent
          @jaccard = jaccard
          @rank = rank
          @activities_intersection = activities_intersection
        end

        def day
          node.day
        end

        def activities_intersection_count
          activities_intersection.length
        end
      end

      def call(location_id:)
        return success({}) if location_id.blank?
        success build_graph(location_id)
      end

      private

      def build_graph(location_id)
        availabilities = load_availabilities location_id

        avails_hash = availabilities.each_with_object({}) do |avail, obj|
          obj[avail.id] = avail
        end

        users = ::User.fetch_multi availabilities.map(&:user_id).uniq

        users_hash = users.each_with_object({}) do |user, obj|
          obj[user.id] = user
        end

        week = availabilities.group_by(&:day).transform_values do |array|
          array.map { |avail| [avail.id, avail.range] }
        end

        matches = week.transform_values do |day|
          graph = ::DataStructures::OverlappingIntervalGraph.build Hash[day]

          graph.each_with_object({}) do |(parent_id, edges), hash|
            rank = 0

            hash[parent_id] = edges.values.map do |edge|
              parent = avails_hash[parent_id]
              node = avails_hash[edge.dig(:node, :id)]
              parent_user = users_hash[parent.user_id]
              node_user = users_hash[node.user_id]
              activities_intersection = (parent_user.settings_activities || []) & (node_user.settings_activities || [])

              next if activities_intersection.empty?

              match = AvailabilityMatch.new(
                parent: parent,
                node: node,
                jaccard: edge[:jaccard],
                rank: rank,
                activities_intersection: activities_intersection
              )

              rank += 1

              match
            end.compact
          end
        end
      end

      def load_availabilities(location_id)
        ::Availability.at_location(location_id).order :day
      end
    end
  end
end
