# frozen_string_literal: true

module Catch
  module GraphQL
    module Types
      class Activity < BaseEnum
        value :LEAD,    value: 1
        value :TOPROPE, value: 2
        value :BOULDER, value: 3
        value :WORKOUT, value: 4
      end
    end
  end
end
