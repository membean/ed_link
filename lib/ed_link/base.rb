# frozen_string_literal: true

module EdLink
  class Base
    include HTTParty
    headers({
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'User-Agent': "EdLink-Ruby/#{EdLink::VERSION}"
    })

    class << self
      def handle_errors(response:)
        error_type = parse_errors(response: response)
        errors = JSON.parse(response.body).deep_symbolize_keys[:$errors]
        headers = response.headers
        raise "EdLink::#{error_type}".constantize.new(errors, headers)
      end

      def next(url:, method: :get, params: {})
        raise_argument_error(label: 'method', param: method, type: Symbol) if method.class != Symbol
        raise_argument_error(label: 'url', param: url, type: String) if url && url.class != String
        
        # Validate the url and form the request
        uri = URI(url.split(base_uri)[1])
        if uri.query.nil? || !uri.query.include?('$cursor=')
          raise ArgumentError.new('Expected "url" to have a "$cursor" query param.')
        end
        cursor = uri.query.split('$cursor=')[1]
        params.merge!({ cursor: cursor })
        request(method: method, path: uri.path, params: params)
      end

      def request(method:, path:, params: {})
        headers(auth_headers(params))
        params = parse_params(params: params)
        response = self.send(method.to_s, path, params)
        json = JSON.parse(response.body).deep_symbolize_keys
        return json if response.code.to_i == 200

        handle_errors(response: response)
      end

      private

      # Customize in the subclasses if needed.
      def auth_headers(params)
        {}
      end

      # Customize in the subclasses if needed.
      def parse_params(params:)
        params.to_h
      end

      def parse_errors(response:)
        case response.code.to_i
        when 400
          'BadRequestError'
        when 403
          'PermissionError'
        when 404
          'NotFoundError'
        when 429
          'RateLimitReachedError'
        else
          'InternalServerError'
        end
      end

      def raise_argument_error(label:, param:, type:)
        raise ArgumentError.new("Expected \"#{label}\" param to be a #{type}, got #{param.class}.")
      end
    end
  end
end
