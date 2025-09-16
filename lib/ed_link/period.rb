# frozen_string_literal: true

module EdLink
  class Period < Base
    
    class << self
      # https://ed.link/docs/api/v2.0/periods/graph-list-periods
      def all(params: {})
        path = '/periods'
        request(method: :get, path: path, params: params)
      end

      # https://ed.link/docs/api/v2.0/periods/graph-get-period
      def find(id:, params: {})
        path = "/periods/#{id}"
        request(method: :get, path: path, params: params)
      end
    end
  end
end