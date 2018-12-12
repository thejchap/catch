module Catch
  module Availability
    module Matching
      class Write < ::Catch::Shared::ServiceBase
        def call(location_id:)
          graph = build location_id
          persist graph, location_id: location_id
          success graph
        end

        private

        def persist(graph, location_id:)
          base_key = "#{Graph::KEY_PREFIX}:#{location_id}"

          redis.multi do |txn|
            txn.set "#{base_key}:updated_at", Time.zone.now

            graph.each do |day, hash|
              txn.set "#{base_key}:day:#{day}", hash.to_json
            end
          end
        end

        def build(location_id)
          services[:build].call(location_id: location_id).value
        end

        def services
          {
            build: Build
          }
        end
      end
    end
  end
end
