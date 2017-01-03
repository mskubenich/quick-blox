module QuickBlox
  module Exceptions
    class MissingConfiguration < Base
      def to_s
        "QB: configuration is missing."
      end
    end
  end
end