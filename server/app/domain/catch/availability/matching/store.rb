# frozen_string_literal: true

module Catch
  module Availability
    module Matching
      class Store
        KEY_PREFIX = 'catch:availability:matching:graph:location'

        class << self
          def write(location, graph)
            base_key = to_key location

            redis.multi do |txn|
              txn.set "#{base_key}:updated_at", Time.zone.now

              graph.each do |day, hash|
                txn.set "#{base_key}:day:#{day}", hash.to_json
              end
            end
          end

          def read(location)
            return Matching::GraphResult.new({}) if location.blank?

            base_key = to_key location
            keys = (0..6).map { |day| "#{base_key}:day:#{day}" }
            keys.push "#{base_key}:updated_at"
            arr = redis.mget(*keys)
            raw_updated = arr.pop

            return Matching::GraphResult.new({}) if arr.compact.empty?

            updated = Time.zone.parse raw_updated

            graph = arr.each_with_object({}).with_index do |(json, hash), day|
              hash[day] = JSON.parse(json).with_indifferent_access
            end

            Matching::GraphResult.new graph, updated
          end

          private

          def to_key(location)
            "#{KEY_PREFIX}:#{location.handle}"
          end

          def redis
            ::Catch::Redis.redis
          end
        end
      end
    end
  end
end
