# frozen_string_literal: true

require_relative './range'
require_relative './enriched_interval_tree'

module DataStructures
  class OverlappingIntervalGraph < ::Hash
    DEFAULT_DEPTH = 5

    class << self
      def build(db, depth: DEFAULT_DEPTH)
        graph = new
        tree = ::DataStructures::EnrichedIntervalTree.new(identify: id_proc)
        db.each { |id, range| tree.insert range, meta: { id: id } }

        tree.each do |node|
          id = node.meta[:id]
          graph[id] = build_row(
            tree,
            depth,
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
          jaccard: range.jaccard(prange)
        }
      end

      def coerce_range(range)
        return range if range.is_a?(range_class)

        range_class.new range.begin, range.end
      end

      def build_row(tree, depth, parent)
        prange = parent[:range]
        pid = parent[:id]

        overlapping = tree.search(prange).first(depth).map do |node|
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
