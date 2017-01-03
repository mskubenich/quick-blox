module QuickBlox
  module Exceptions
    class ResourceNotFound < Base
      def to_s
        "QB: resource not found."
      end
    end
  end
end