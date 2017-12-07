module QuickBlox
  class UserSession < Session

    attr_accessor :user
    attr_accessor :session

    def initialize(application_session, options={})

      self.session = application_session

      raise QuickBlox::Exceptions::MissingConfiguration unless QuickBlox.configuration

      RestClient::Request.execute(
          method: :post,
          url: "#{ QuickBlox.configuration.host }/login.json",
          payload: {
              login: options[:login],
              password: options[:password]
          }.to_json,
          headers: {
              'Content-Type': 'application/json',
              'QuickBlox-REST-API-Version': QuickBlox.configuration.api_version,
              'QB-Token': application_session.token
          }
      ){ |response, request, result|
        response = JSON.parse(response)
        case result.code.to_i
          when 200, 201, 202
            user = QuickBlox::User.new
            response['user'].each do |k, v|
              user.instance_variable_set "@#{k}", v
            end
          else
            raise QuickBlox::Exceptions::Response, response['errors']
        end
      }
    end

    def destroy(application_session)
      RestClient::Request.execute(
          method: :delete,
          url: "#{ QuickBlox.configuration.host }/login.json",
          headers: {
              'Content-Type': 'application/json',
              'QuickBlox-REST-API-Version': QuickBlox.configuration.api_version,
              'QB-Token': application_session.token
          }
      ){ |response, request, result|
        case result.code.to_i
          when 200

          else
            response = JSON.parse(response)
            raise QuickBlox::Exceptions::Response, response['errors']
        end
      }
    end

    def self.destroy_by_token(token)
      RestClient::Request.execute(
          method: :delete,
          url: "#{ QuickBlox.configuration.host }/login.json",
          headers: {
              'Content-Type': 'application/json',
              'QuickBlox-REST-API-Version': QuickBlox.configuration.api_version,
              'QB-Token': token
          }
      ){ |response, request, result|
        case result.code.to_i
          when 200

          else
            response = JSON.parse(response)
            raise QuickBlox::Exceptions::Response, response['errors']
        end
      }
    end
  end
end