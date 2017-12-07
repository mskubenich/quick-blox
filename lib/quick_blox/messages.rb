require 'base64'
require 'cgi'
require 'openssl'
require 'hmac-sha1'

module QuickBlox
  class Messages
    include Enumerable

    attr_accessor :skip
    attr_accessor :limit
    attr_accessor :items

    # Search by _id, type, name, last_message_date_sent, created_at, updated_at

    # Options:
    # {search: {name: 'test'}}
    # {search: {type: in: [1, 2]}
    # {search: {last_message_date_sent: {less_than: Time.now}}
    # {search: {last_message_date_sent: {less_than_or_equal_to: Time.now}}
    # {search: {last_message_date_sent: {greater_than: Time.now}}
    # {search: {last_message_date_sent: {greater_than_or_equal_to: Time.now}}
    # {search: {last_message_date_sent: {not_equal_to: Time.now}}
    # {search: {last_message_date_sent: {in: [Time.now, Date.tomorrow]}}
    # {search: {last_message_date_sent: {not_in: [Time.now, Date.tomorrow]}}
    # {search: {last_message_date_sent: {all_in: [Time.now, Date.tomorrow]}}
    # {search: {last_message_date_sent: {contains: 'test'}}
    # {limit: 100, skip: 100, count: 10}
    # {sort_desc: 'last_message_date_sent'}
    # {sort_asc: 'last_message_date_sent'}

    # Possible filters:
    # lt (Less Than operator),
    # lte (Less Than or Equal to operator),
    # gt (Greater Than operator),
    # gte (Greater Than or Equal to operator),
    # ne (Not Equal to operator),
    # in (Contained IN array operator),
    # nin (Not contained IN array),
    # all (ALL contained IN array),
    # ctn (Contains substring operator)

    def self.list(session, options = {})
      instance = new

      url = "#{ QuickBlox.configuration.host }/chat/Message.json?chat_dialog_id=#{ options[:chat_dialog_id] }&"

      RestClient::Request.execute(
          method: :get,
          url: url,
          headers: {
              'QuickBlox-REST-API-Version': QuickBlox.configuration.api_version,
              'QB-Token': session.token
          }
      ){ |response, request, result|
        parsed_response = JSON.parse(response.body)

        case result.code.to_i
          when 200
            instance.skip = parsed_response['skip']
            instance.limit = parsed_response['limit']
            instance.items = []

            parsed_response['items'].each do |params|
              instance.items << QuickBlox::Message.new(params)
            end
          else
            response = JSON.parse(response)
            raise QuickBlox::Exceptions::Response, response['errors']
        end
      }

      instance
    end

    def each(&block)
      items.each(&block)
    end
  end
end