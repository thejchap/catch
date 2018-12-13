# frozen_string_literal: true

module Catch
  module Authorization
    module Policies
      class AvailabilityPolicy < ApplicationPolicy
        def show?
          true
        end

        def update?
          record.user_id == user.id
        end

        def destroy?
          record.user_id == user.id
        end
        alias delete? destroy?
      end
    end
  end
end
