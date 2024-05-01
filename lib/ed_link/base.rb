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

        # Grab value or assign to nil.
        expand = params[:expand]
        fields = params[:fields]
        filter = params[:filter]

        # Ensure params are in the correct format.
        raise_argument_error(label: 'expand',param: expand, type: String) if expand && expand.class != String
        raise_argument_error(label: 'fields', param: fields, type: String) if fields && fields.class != String
        raise_argument_error(label: 'filter', param: filter, type: Hash)if filter && filter.class != Hash
          
        compiled = {}
        # Add any expand params that are present.
        compiled.merge!({ '$expand' => params[:expand].gsub(/[[:space:]]/, '') }) if expand.present?
        # Add any field params that are present.
        compiled.merge!({ '$fields' => params[:fields].gsub(/[[:space:]]/, '') }) if fields.present?
        # Add any filter params that are present.
        compiled.merge!({ '$filter' => params[:filter].to_json }) if filter.present?
        # Return the query hash for HTTParty.
        { query: compiled }
      end

      def raise_argument_error(label:, param:, type:)
        raise ArgumentError.new("Expected \"#{label}\" param to be a #{type}, got #{param.class}.")
      end
    end
  end
end