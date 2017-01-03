module QuickBlox
  module Exceptions
    class Response < Base
      attr_reader :code

      def initialize(messages)
        @messages = messages
      end

      def to_s
        result_message = []
        @messages.each do |k,v|
          v.each do |message|
            result_message << "QB: #{ k }: #{ message }"
          end
        end
        result_message.join('. ')
      end
    end
  end
end