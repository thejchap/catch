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
      end
    end
  end
end
