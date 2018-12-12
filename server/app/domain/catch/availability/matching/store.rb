module Catch
  module Availability
    module Matching
      class Store
        KEY_PREFIX = 'catch:availability:matching:graph:location'.freeze

        class << self
          def write(location_id, graph)
            base_key = "#{KEY_PREFIX}:#{location_id}"
            now = Time.zone.now

            redis.multi do |txn|
              txn.set "#{base_key}:updated_at", now

              graph.each do |day, hash|
                txn.set "#{base_key}:day:#{day}", hash.to_json
              end
            end

            Matching::GraphResult.new graph, now
          end

          def read(location_id)
            return {} if location_id.blank?

            keys = (0..6).map { |day| "#{KEY_PREFIX}:#{location_id}:day:#{day}" }
            keys.push "#{KEY_PREFIX}:#{location_id}:updated_at"
            arr = redis.mget(*keys)
            updated = Time.zone.parse arr.pop

            return {} if arr.compact.empty?

            graph = arr.each_with_object({}).with_index do |(json, hash), day|
              hash[day] = JSON.parse(json).with_indifferent_access
            end

            Matching::GraphResult.new graph, updated
          end

          private

          def redis
            ::Catch::Redis.redis
          end
        end
      end
    end
  end
end
