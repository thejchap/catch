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
        rescue Wolverine::LuaError => e
          nil
        end

        def minify(contents)
          contents.gsub /\n+/, ''
        end
      end
    end
  end
end
