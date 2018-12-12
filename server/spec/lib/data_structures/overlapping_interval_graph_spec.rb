# frozen_string_literal: true

require 'spec_helper'
require_relative '../../../app/lib/data_structures/overlapping_interval_graph'

module DataStructures
  RSpec.describe OverlappingIntervalGraph do
    it 'works' do
      db = {
        1 => 1..3,
        2 => 2..4,
        3 => 5..6,
        4 => 1..3
      }

      graph = described_class.build db

      expect(graph[1].first[0]).to eq 4
    end

    skip 'benchmarks' do
      benchmark_matcher { |db| described_class.build db }
    end
  end
end
