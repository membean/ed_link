# frozen_string_literal: true

module EdLink
  class GraphBase < Base
    base_uri 'https://ed.link/api/v2/graph'

    class << self

      private

      def auth_headers(params)
        access_token = params[:access_token]
        access_token ||= EdLink.configuration.access_token
        { 'Authorization': "Bearer #{access_token}" }
      end

      def parse_params(params:)
        return params if params == {}

        # Gets the value or assigns nil
        cursor = params[:cursor]
        expand = params[:expand]
        fields = params[:fields]
        filter = params[:filter]
        first = params[:first]

        # Ensure params are in the correct format.
        raise_argument_error(label: 'cursor', param: expand, type: String) if cursor && cursor.class != String
        raise_argument_error(label: 'expand', param: expand, type: String) if expand && expand.class != String
        raise_argument_error(label: 'fields', param: fields, type: String) if fields && fields.class != String
        raise_argument_error(label: 'filter', param: filter, type: Hash)if filter && filter.class != Hash
        raise_argument_error(label: 'first', param: first, type: Integer)if first && first.class != Integer
          
        compiled = {}
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
    end
  end
end
