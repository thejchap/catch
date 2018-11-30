require_relative '../interval_tree/node.rb'
require_relative '../interval_tree.rb'

module DataStructures
  class EnrichedIntervalTree < IntervalTree
    class Node < ::DataStructures::IntervalTree::Node
      attr_accessor :meta

      def initialize(range, meta: {})
        super(range)
        @meta = meta
      end
    end
  end
end
