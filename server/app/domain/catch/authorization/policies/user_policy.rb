module Catch
  module Authorization
    module Policies
      class UserPolicy < ApplicationPolicy
        def show?
          true
        end
      end
    end
  end
end
