module Catch
  module Availability
    module Matching
      class Graph < ::Catch::Shared::ServiceBase
        KEY_PREFIX = 'catch:availability:matching:graph:location'.freeze

        def call(location_id:)
          success fetch(location_id)
        end

        private

        def fetch(location_id)
          return {} if location_id.blank?

          keys = (0..6).map { |day| "#{KEY_PREFIX}:#{location_id}:day:#{day}" }
          keys.push "#{KEY_PREFIX}:#{location_id}:updated_at"
          arr = redis.mget(*keys)
          updated = Time.zone.parse arr.pop

          return {} if arr.compact.empty?

          graph = arr.each_with_object({}).with_index do |(json, hash), day|
            hash[day] = JSON.parse(json).with_indifferent_access
          end

          OpenStruct.new graph: graph, updated_at: updated
        end
      end
    end
  end
end
