require 'base64'
require 'cgi'
require 'openssl'
require 'hmac-sha1'

module QuickBlox
  class Dialog
    attr_accessor :_id
    attr_accessor :created_at
    attr_accessor :updated_at
    attr_accessor :last_message
    attr_accessor :last_message_date_sent
    attr_accessor :last_message_user_id
    attr_accessor :name
    attr_accessor :photo
    attr_accessor :occupants_ids
    attr_accessor :type
    attr_accessor :unread_messages_count
    attr_accessor :xmpp_room_jid
    attr_accessor :session

    def initialize(session, options = {})
      self.session = session

      options.each do |k, v|
        self.instance_variable_set "@#{k}", v
      end
    end

    def messages
      QuickBlox::Messages.list session, chat_dialog_id: self._id
    end
  end
end