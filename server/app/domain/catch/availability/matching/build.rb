# frozen_string_literal: true

module Catch
  module Availability
    module Matching
      class Build < ::Service::Base
        def call(location:)
          @location = location
          success graphs
        end

        private

        def availabilities
          @availabilities ||= ::Availability.at_location(
            @location.id
          ).pluck(:id, :day, :range, :user_id)
        end

        def availabilities_by_day
          @availabilities_by_day ||= availabilities.group_by { |avail| avail[1] }
        end

        def user_ids_hash
          @user_ids_hash ||= availabilities.each_with_object({}) do |avail, obj|
            obj[avail[0]] = avail[3]
          end
        end

        def settings_hash
          @settings_hash ||= load_settings
        end

        def load_settings
          query = ::User.settings_where(
            settings_location: @location.id
          ).pluck(Arel.sql('id, settings->\'activities\''))

          query.each_with_object({}) do |user, obj|
            obj[user[0]] = user[1]
          end
        end

        def week
          @week ||= begin
                      (0..6).each_with_object({}) do |day, obj|
                        obj[day] = (availabilities_by_day[day] || []).map do |avail|
                          [avail[0], avail[2]]
                        end
                      end
                    end
        end

        def build_edge_list(edges, parent_activities)
          rank = 0
          filtered = []

          edges.each do |edge|
            node_user_id = user_ids_hash[edge.dig(:node, :id)]
            arr1 = settings_hash[node_user_id]
            arr2 = parent_activities
            intersection = arr1 & arr2

            next if intersection.empty?

            edge.merge!(
              activities_intersection: intersection,
              parent_activities: parent_activities,
              node_activities: arr1,
              rank: rank
            )

            rank += 1
            filtered.push edge
          end

          filtered
        end

        def graphs
          week.transform_values do |day|
            graph = ::DataStructures::OverlappingIntervalGraph.build Hash[day]

            graph.each_with_object({}) do |(parent_id, edges), hash|
              parent_user_id = user_ids_hash[parent_id]
              parent_activities = settings_hash[parent_user_id]
              hash[parent_id] = build_edge_list(edges.values, parent_activities)
            end
          end
        end
      end
    end
  end
end
