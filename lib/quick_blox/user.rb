module QuickBlox
  class User

    attr_accessor :id, :owner_id, :full_name, :email, :login, :phone, :website, :created_at, :updated_at, :last_request_at,
                  :external_user_id, :facebook_id, :twitter_id, :blob_id, :custom_data, :twitter_digits_id, :user_tags

    def self.create(application_session, options)

      raise QuickBlox::Exceptions::MissingConfiguration unless QuickBlox.configuration

      RestClient::Request.execute(
          method: :post,
          url: "#{ QuickBlox.configuration.host }/users.json",
          payload: {
              user: {
                login: options[:login],
                password: options[:password]
              }
          }.to_json,
          headers: {
              'Content-Type': 'application/json',
              'QuickBlox-REST-API-Version': QuickBlox.configuration.api_version,
              'QB-Token': application_session.token
          }
      ){ |response, request, result|
        response = JSON.parse(response)

        case result.code.to_i
          when 201
            instance = QuickBlox::User.new
            response['user'].each do |k, v|
              instance.instance_variable_set "@#{k}", v
            end
            return instance
          else
            raise QuickBlox::Exceptions::Response, response['errors']
        end
      }
    end

    def self.show(application_session, user_id)
      RestClient::Request.execute(
          method: :get,
          url: "#{ QuickBlox.configuration.host }/users/#{ user_id }.json",
          headers: {
              'QuickBlox-REST-API-Version': QuickBlox.configuration.api_version,
              'QB-Token': application_session.token
          }
      ){ |response, request, result|
        response = JSON.parse(response)

        case result.code.to_i
          when 200
            instance = QuickBlox::User.new
            response['user'].each do |k, v|
              instance.instance_variable_set "@#{k}", v
            end
            return instance
          when 404
            raise QuickBlox::Exceptions::ResourceNotFound
          else
            raise QuickBlox::Exceptions::Response, response['errors']
        end
      }
    end

    def destroy(application_session)
      RestClient::Request.execute(
          method: :delete,
          url: "#{ QuickBlox.configuration.host }/users/#{ self.id }.json",
          headers: {
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
  end
end