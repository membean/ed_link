# frozen_string_literal: true

module EdLink
  class District < Base
    
    class << self
      # https://ed.link/docs/api/v2.0/districts/graph-list-district-administrators
      def administrators(id:, params: {})
        path = "/districts/#{id}/administrators"
        request(method: :get, path: path, params: params)
      end

      # https://ed.link/docs/api/v2.0/districts/graph-list-districts
      def all(params: {})
        path = '/districts'
        request(method: :get, path: path, params: params)
      end

      # https://ed.link/docs/api/v2.0/districts/graph-get-district
      def find(id:, params: {})
        path = "/districts/#{id}"
        request(method: :get, path: path, params: params)
      end
    end
  end
end