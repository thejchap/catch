module Catch
  module Authorization
    module Policies
      class UserPolicy < ApplicationPolicy
        def show?
          record.id == user.id
        end
      end
    end
  end
end
