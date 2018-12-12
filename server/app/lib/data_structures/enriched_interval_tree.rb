# frozen_string_literal: true

require_relative './enriched_interval_tree/node.rb'
require_relative './interval_tree.rb'

module DataStructures
  class EnrichedIntervalTree < IntervalTree
    attr_accessor :identify

    def initialize(*ranges, node_class: Node, identify: nil)
      super(*ranges, node_class: node_class)
      self.identify = identify
    end

    def insert(range, meta: {})
      super(range) { |node| node.meta = meta }
    end

    def search(range_or_interval)
      super.reject do |result|
        next false if identify.nil?

        node = range_or_interval.is_a?(node_class) ? node : node_class.new(range_or_interval)
        identify.call(result) == identify.call(node)
      end
    end
  end
end
