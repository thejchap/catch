# frozen_string_literal: true

module DataStructures
  class Range < ::Range
    def intersection(other)
      return if self.end < other.begin || other.end < self.begin

      [self.begin, other.begin].max..[self.end, other.end].min
    end
    alias & intersection

    def union(other)
      [self.begin, other.begin].min..[self.end, other.end].max
    end
    alias | union

    def jaccard(other)
      return 1.0 if self == other

      return 0.0 unless overlaps?(other)

      ((self & other).size.to_f / (self | other).size.to_f).round 2
    end

    def distance(other)
      return 0.0 if overlaps?(other)

      return other.begin - self.end if self.end < other.begin

      self.begin - other.end
    end

    def overlaps?(other)
      cover?(other.first) || other.cover?(first)
    end
  end
end
