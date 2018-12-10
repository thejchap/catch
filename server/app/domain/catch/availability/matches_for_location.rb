module Catch
  module Availability
    class MatchesForLocation < ::Service::Base
      class AvailabilityMatch
        attr_reader :node, :parent, :jaccard, :rank, :day

        def initialize(node:, parent:, jaccard:, rank:)
          @node     = node
          @parent   = parent
          @jaccard  = jaccard
          @rank     = rank
          @day      = node.day
        end
      end

      def call(location_id:)
        return failure(nil) if location_id.blank?
        success build_graph(location_id)
      end

      private

      def build_graph(location_id)
        availabilities = load_availabilities location_id

        avails_hash = availabilities.each_with_object({}) do |avail, obj|
          obj[avail.id] = avail
        end

        week = availabilities.group_by(&:day).transform_values do |array|
          array.map { |avail| [avail.id, avail.range] }
        end

        matches = week.transform_values do |day|
          graph = ::DataStructures::OverlappingIntervalGraph.build Hash[day]

          graph.each_with_object({}) do |(parent_id, edges), hash|
            hash[parent_id] = edges.values.each_with_index.map do |edge, rank|
              AvailabilityMatch.new(
                parent:   avails_hash[parent_id],
                node:     avails_hash[edge.dig(:node, :id)],
                jaccard:  edge[:jaccard],
                rank:     rank
              )
            end
          end
        end
      end

      def load_availabilities(location_id)
        ::Availability.at_location(location_id).order :day
      end
    end
  end
end
