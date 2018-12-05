module Catch
  module Client
    module Web
      class FetchIndex < Shared::ServiceBase
        def call
          success wolverine.fetch_index
        end
      end
    end
  end
end
