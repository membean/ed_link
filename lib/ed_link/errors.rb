# frozen_string_literal: true

module EdLink
  # There can be multiple errors in the response, so we only add
  # the first error message to the Exception. You can get at all
  # the error messages by looking at the .errors method of the
  # exception:
  #
  # begin
  #   filter = {district_id: [{operator: 'equals', value: '...'}]}
  #   EdLink::School.all(filter: filter)
  # rescue EdLink::BadRequestError => error
  #   puts error.errors
  #   puts error.headers
  #  end
  #
  class EdLinkError < StandardError
    attr_reader :errors, :headers

    def initialize(errors, headers)
      @errors = errors
      @headers = headers
      if @errors.is_a?(Array)
        message = "#{@errors.first[:message]} (1/#{@errors.length} errors)"
      else
        message = "#{@errors} (1/1 errors)"
      end
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

  class UnauthorizedError < EdLinkError; end
end