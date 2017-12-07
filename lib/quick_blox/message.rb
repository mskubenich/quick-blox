require 'base64'
require 'cgi'
require 'openssl'
require 'hmac-sha1'

module QuickBlox
  class Message
    include Enumerable

    attr_accessor :_id
    attr_accessor :attachments
    attr_accessor :chat_dialog_id
    attr_accessor :created_at
    attr_accessor :date_sent
    attr_accessor :delivered_ids
    attr_accessor :message
    attr_accessor :read_ids
    attr_accessor :recipient_id
    attr_accessor :sender_id
    attr_accessor :updated_at
    attr_accessor :read

    def initialize(options)
      options.each do |k, v|
        self.instance_variable_set "@#{k}", v
      end
    end
  end
end