module QuickBlox
  module Exceptions
    class Response < Base
      attr_reader :code

      def initialize(messages)
        @messages = messages
      end

      def to_s
        result_message = []

        if @messages.kind_of?(Array)
          @messages.each do |v|
            result_message << "QB: #{ v }"
          end
          result_message.join('. ')
        else
          @messages.each do |k,v|
            v.to_a.each do |message|
              result_message << "QB: #{ k }: #{ message }"
            end
          end
          result_message.join('. ')
        end
      end
    end
  end
end