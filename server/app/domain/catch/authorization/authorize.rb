# frozen_string_literal: true

module Catch
  module Authorization
    class Authorize < ::Service::Base
      def call(user, action, object)
        policy = find_policy user, object
        result = policy.public_send action
        return success(result) if result == true

        failure result
      end

      private

      def find_policy(user, object)
        Pundit.policy!(user, [:catch, :authorization, :policies, object])
      end
    end
  end
end
