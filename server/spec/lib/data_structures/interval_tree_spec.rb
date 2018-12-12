# frozen_string_literal: true

require 'spec_helper'
require_relative '../../../app/lib/data_structures/interval_tree.rb'

module DataStructures
  RSpec.describe IntervalTree do
    # test case taken from:
    # http://www.davismol.net/2016/02/07/data-structures-augmented-interval-tree-to-search-for-interval-overlapping/
    it 'searches' do
      tree = described_class.new(
        5..10,
        15..25,
        1..12,
        8..16,
        14..20,
        18..21,
        2..8
      )

      expect(tree.search(8..10).map(&:range)).to eq([5..10, 1..12, 2..8, 8..16])
    end
  end
end
