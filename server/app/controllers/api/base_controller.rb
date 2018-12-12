# frozen_string_literal: true

module API
  class BaseController < ::ActionController::API
    before_action :doorkeeper_authorize!

    protected

    def current_resource_owner
      return if doorkeeper_token.blank?

      @current_resource_owner ||= User.fetch(doorkeeper_token.resource_owner_id)
    end
  end
end
