require 'set'
require_relative './interval_tree/node.rb'
require_relative './range.rb'

module DataStructures
  class IntervalTree
    attr_reader :root, :node_class

    def initialize(*ranges, node_class: Node)
      return if ranges.nil?
      @node_class = node_class
      Set[*ranges].each { |range| insert range }
    end

    def search(range_or_interval)
      return if root.nil?
      return search_node(root, range_or_interval) if range_or_interval.is_a?(node_class)
      search_node root, @node_class.new(range_or_interval)
    end

    def insert(range)
      node = @node_class.new ::DataStructures::Range.new(
        range.begin,
        range.end
      )

      yield(node) if block_given?

      root.nil? ? @root = node : root.insert(node)
    end

    def each(&block)
      return if root.nil?
      root.each(&block)
    end

    private

    def search_node(root, node, results = [])
      return if root.nil?
      return if node > root

      results << root if root.overlaps?(node)

      if !root.left.nil? && root.left.max > node.low
        search_node root.left, node, results
      end

      search_node(root.right, node, results) unless root.right.nil?
      results
    end
  end
end
