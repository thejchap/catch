module Catch
  module GraphQL
    module Types
      class Weekday < BaseEnum
        ::Wday::ALL.each do |wday|
          value wday.to_s.upcase, value: wday.to_s
        end
      end
    end
  end
end
