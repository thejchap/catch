# frozen_string_literal: true

module Catch
  module Authorization
    module Policies
      class LocationPolicy < ApplicationPolicy
        def show?
          true
        end
      end
    end
  end
end
