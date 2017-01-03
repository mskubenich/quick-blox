require "quick_blox/version"
require "quick_blox/configuration"
require "quick_blox/session"
require "quick_blox/user"
require "quick_blox/user_session"
require "quick_blox/exceptions/base"
require "quick_blox/exceptions/missing_application_session"
require "quick_blox/exceptions/missing_configuration"
require "quick_blox/exceptions/resource_not_found"
require "quick_blox/exceptions/response"

module QuickBlox
  class << self
    attr_accessor :configuration

    def configure
      self.configuration ||= QuickBlox::Configuration.new
      yield(configuration)
    end
  end
end
