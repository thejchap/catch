require_relative './range'
require_relative './enriched_interval_tree'

module DataStructures
  class OverlappingIntervalGraph < ::Hash
    class << self
      def build(db)
        graph = new
        tree = EnrichedIntervalTree.new(identify: id_proc)
        db.each { |id, range| tree.insert range, meta: { id: id } }

        tree.each do |node|
          id = node.meta[:id]
          graph[id] = build_row(
            db,
            tree,
            id: node.meta[:id],
            range: node.range
          )
        end

        graph
      end

      private

      def range_class
        ::DataStructures::Range
      end

      def id_proc
        ->(node) { node.meta[:id] }
      end

      def build_edge(prange, id, range)
        {
          node: { range: range, id: id },
          jaccard: range.jaccard(prange),
        }
      end

      def coerce_range(range)
        return range if range.is_a?(range_class)
        range_class.new range.begin, range.end
      end

      def build_row(db, tree, parent)
        prange = parent[:range]
        pid = parent[:id]

        overlapping = tree.search(prange).map do |node|
          build_edge prange, node.meta[:id], node.range
        end

        overlapping.sort_by! { |edge| -edge[:jaccard] }
        overlapping.each_with_object({}) do |edge, hash|
          id = edge[:node][:id]
          next if id == pid
          hash[id] = edge
        end
      end
    end
  end
end
