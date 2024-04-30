# frozen_string_literal: true

module EdLink
  class EdLinkError < StandardError
    attr_reader :errors, :headers

    def initialize(errors, headers)
      @errors = errors
      @headers = headers
      message = 'Check .errors and .headers for more information about this error.'
      super(message)
    end
  end

  class BadGatewayError < EdLinkError; end

  class BadRequestError < EdLinkError; end
  
  class ConfigurationError < StandardError; end

  class InternalServerError < EdLinkError; end

  class NotFoundError < EdLinkError; end

  class PermissionError < EdLinkError; end

  class RateLimitReachedError < EdLinkError; end
end