module Catch
  module Availability
    module Matching
      class Build < ::Service::Base
        def call(location_id:)
          @location = ::Location.fetch location_id
          success graphs
        end

        private

        def availabilities
          @availabilities ||= ::Availability.at_location(@location.id).order(:day).to_a
        end

        def availabilities_hash
          @availabilities_hash ||= availabilities.each_with_object({}) do |avail, obj|
            obj[avail.id] = avail
          end
        end

        def availabilities_by_day
          @availabilities_by_day ||= availabilities.group_by(&:day)
        end

        def users
          @users ||= ::User.fetch_multi(availabilities.map(&:user_id).uniq)
        end

        def users_hash
          @users_hash ||= users.each_with_object({}) do |user, obj|
            obj[user.id] = user
          end
        end

        def week
          @week ||= ((0..6).each_with_object({}) do |day, obj|
            obj[day] = (availabilities_by_day[day] || []).map do |avail|
              [avail.id, avail.range]
            end
          end)
        end

        def build_edge_list(edges, parent, parent_user)
          rank = 0
          filtered = []

          edges.values.each do |edge|
            node = availabilities_hash[edge.dig(:node, :id)]
            node_user = users_hash[node.user_id]
            arr1 = node_user.settings_activities
            arr2 = parent_user.settings_activities
            intersection = arr1 & arr2

            next if intersection.empty?

            edge.merge! activities_intersection: intersection, rank: rank
            rank += 1
            filtered.push edge
          end

          filtered
        end

        def graphs
          week.transform_values do |day|
            graph = ::DataStructures::OverlappingIntervalGraph.build Hash[day]

            graph.each_with_object({}) do |(parent_id, edges), hash|
              parent = availabilities_hash[parent_id]
              parent_user = users_hash[parent.user_id]
              hash[parent_id] = build_edge_list edges, parent, parent_user
            end
          end
        end
      end
    end
  end
end
