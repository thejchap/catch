# frozen_string_literal: true

module Helpers
  module ServiceHelpers
    def call(*args)
      described_class.call(*args)
    end
  end
end
