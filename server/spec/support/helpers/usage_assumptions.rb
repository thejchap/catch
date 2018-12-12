# frozen_string_literal: true

require 'ostruct'
require 'benchmark'

module Helpers
  module UsageAssumptions
    class Assumption
      attr_reader(
        :members_per_location,
        :availabilities_per_user_per_day,
        :adoption,
        :visits_per_user_per_week
      )

      def initialize(mpl, apd, adpt, vpw)
        @members_per_location             = mpl
        @availabilities_per_user_per_day  = apd
        @adoption                         = adpt
        @visits_per_user_per_week         = vpw
      end

      def matcher_load
        (
          members_per_location *
          adoption *
          availabilities_per_user_per_day *
          (visits_per_user_per_week.to_f / 7.0)
        ).round
      end
    end

    def usage_assumptions
      @usage_assumptions ||= {
        low: Assumption.new(500,  2, 0.3, 3),
        med: Assumption.new(1000, 2, 0.3, 3),
        high: Assumption.new(3000, 2, 0.5, 3)
      }
    end

    def benchmark_matcher
      Benchmark.bm do |x|
        usage_assumptions.each do |name, assumption|
          db = {}

          Array.new(assumption.matcher_load) do |i|
            rand1 = rand 1..24
            rand2 = rand 1..24
            db[i + 1] = [rand1, rand2].min..[rand1, rand2].max
          end

          x.report "#{name}: #{assumption.matcher_load}" do
            yield db
          end
        end
      end
    end
  end
end
