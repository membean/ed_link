# frozen_string_literal: true

module EdLink
  class Base
    include HTTParty
    base_uri 'https://ed.link/api/v2/graph'
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

      # TODO: filter and fields need to be accepted as params.
      def request(method:, path:, params: {})
        headers({ 'Authorization': "Bearer #{EdLink.configuration.access_token}" })
        params = parse_params(params: params)
        response = self.send(method.to_s, path, params)
        json = JSON.parse(response.body).deep_symbolize_keys
        return json if response.code.to_i == 200

        handle_errors(response: response)
      end

      private

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

      def parse_params(params:)
        return params if params == {}
        compiled = {}
        # Add any field params that are present.
        if params.has_key?(:fields) && params[:fields] != {}
          compiled.merge!({ '$fields' => params[:fields].gsub(/[[:space:]]/, '') })
        end
        # Add any filter params that are present.
        if params.has_key?(:filter) && params[:filter] != {}
          compiled.merge!({ '$filter' => params[:filter].to_json })
        end
        { query: compiled }
      end
    end
  end
end