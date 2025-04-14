module EdLink
  class Configuration
    attr_writer :app_secret, :access_token

    def initialize
      @app_secret = nil
      @access_token = nil
    end

    def app_secret
      raise EdLink::ConfigurationError, 'EdLink App Secret is missing!' unless @app_secret
      @app_secret
    end

    def access_token
      raise EdLink::ConfigurationError, 'EdLink Access Token is missing!' unless @access_token
      @access_token
    end
  end
end
