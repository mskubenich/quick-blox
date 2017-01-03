module QuickBlox
  class Configuration
    attr_accessor :host,
                  :application_id,
                  :auth_key,
                  :auth_secret,
                  :api_version

    def initialize
      @api_version = '0.1.0'
    end

    def options=(options)
      options.each do |k,v|
        instance_variable_set(:"@#{k}",v)
      end
    end

    def to_hash
      Hash[instance_variables.map { |name| [name.to_s.gsub("@","").to_sym, instance_variable_get(name)] } ]
    end
  end
end