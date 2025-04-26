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
        json = JSON.parse(response.body).deep_symbolize_keys
        # Some error responses, such as 401 Unauthorized, have an $error
        # key (singular) instead of an $errors key (plural).
        errors = json[:$errors] || json[:$error]
        headers = response.headers
        raise "EdLink::#{error_type}".constantize.new(errors, headers)
      end

      def next(url:, method: :get, params: {})
        raise_argument_error(label: 'method', param: method, type: Symbol) if method.class != Symbol
        raise_argument_error(label: 'url', param: url, type: String) if url && url.class != String
        
        # Validate the url and form the request
        uri = URI(url.split(EdLink::Base.base_uri)[1])
        if uri.query.nil? || !uri.query.include?('$cursor=')
          raise ArgumentError.new('Expected "url" to have a "$cursor" query param.')
        end
        path = uri.path
        cursor = uri.query.split('$cursor=')[1]
        params.merge!({ cursor: cursor })
        params = parse_params(params: params)
        request(method: method, path: path, params: params)
      end

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
        when 401
          'UnauthorizedError'
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

        # Gets the value or assigns nil
        after = params[:after]
        before = params[:before]
        cursor = params[:cursor]
        expand = params[:expand]
        fields = params[:fields]
        filter = params[:filter]
        first = params[:first]

        # Ensure params are in the correct format.
        raise_argument_error(label: 'after', param: after, type: String) if after && after.class != String
        raise_argument_error(label: 'before', param: before, type: String) if before && before.class != String
        raise_argument_error(label: 'cursor', param: expand, type: String) if cursor && cursor.class != String
        raise_argument_error(label: 'expand', param: expand, type: String) if expand && expand.class != String
        raise_argument_error(label: 'fields', param: fields, type: String) if fields && fields.class != String
        raise_argument_error(label: 'filter', param: filter, type: Hash)if filter && filter.class != Hash
        raise_argument_error(label: 'first', param: first, type: Integer)if first && first.class != Integer
          
        compiled = {}
        # Add the after param if present.
        compiled.merge!({ '$after' => params[:after] }) if after.present?
         # Add the before param if present.
         compiled.merge!({ '$before' => params[:before] }) if before.present?
        # Add the cursor param if present.
        compiled.merge!({ '$cursor' => params[:cursor] }) if cursor.present?
        # Add the expand param if present.
        compiled.merge!({ '$expand' => params[:expand].gsub(/[[:space:]]/, '') }) if expand.present?
        # Add the field params if present.
        compiled.merge!({ '$fields' => params[:fields].gsub(/[[:space:]]/, '') }) if fields.present?
        # Add the filter params if present.
        compiled.merge!({ '$filter' => params[:filter].to_json }) if filter.present?
        # Add the first params if present.
        compiled.merge!({ '$first' => params[:first].to_i }) if first.present?
        # Return the query hash for HTTParty.
        { query: compiled }
      end

      def raise_argument_error(label:, param:, type:)
        raise ArgumentError.new("Expected \"#{label}\" param to be a #{type}, got #{param.class}.")
      end
    end
  end
end
