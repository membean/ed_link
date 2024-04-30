module EdLink
  class Configuration
    attr_writer :access_token

    def initialize
      @access_token = nil
    end

    def access_token
      raise EdLink::ConfigurationError, 'EdLink API secret is missing!' unless @access_token
      @access_token
    end
  end
end