# frozen_string_literal: true

module DataStructures
  class IntervalTree
    class Node
      attr_reader :range, :max, :left, :right

      def initialize(range)
        @range = range
        @max = high
      end

      def insert(node)
        if node < self
          left.nil? ? @left = node : left.insert(node)
        else
          right.nil? ? @right = node : right.insert(node)
        end

        @max = node.high if node.high > max
        node
      end

      def high
        range.end
      end
      alias last high

      def low
        range.begin
      end
      alias first low

      def cover?(other)
        range.cover? other
      end

      def >(other)
        low > other.max
      end

      def <(other)
        max < other.low
      end

      def each(&block)
        left&.each(&block)
        yield self
        right&.each(&block)
      end

      def overlaps?(other)
        range.overlaps? other.range
      end
    end
  end
end
