# frozen_string_literal: true

module Catch
  module Client
    module Web
      class FetchIndex < Shared::ServiceBase
        def call
          success index
        end

        private

        def index
          minify wolverine.fetch_index
        rescue Wolverine::LuaError
          nil
        end

        def minify(contents)
          contents.gsub(/\n+/, '')
        end
      end
    end
  end
end
