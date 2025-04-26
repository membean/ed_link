# frozen_string_literal: true

module EdLink
  class Enrollment < Base
    
    class << self
      # https://ed.link/docs/api/v2.0/enrollments/graph-list-enrollments
      def all(params: {})
        path = '/enrollments'
        request(method: :get, path: path, params: params)
      end

      # https://ed.link/docs/api/v2.0/enrollments/graph-get-enrollment
      def find(id:, params: {})
        path = "/enrollments/#{id}"
        request(method: :get, path: path, params: params)
      end
    end
  end
end