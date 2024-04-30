# frozen_string_literal: true

module EdLink
  class Course < Base
    
    class << self
      # https://ed.link/docs/api/v2.0/courses/graph-list-courses
      def all(params: {})
        path = '/courses'
        request(method: :get, path: path, params: params)
      end

      # https://ed.link/docs/api/v2.0/courses/graph-list-classes
      def classes(id:, params: {})
        path = "/courses/#{id}/classes"
        request(method: :get, path: path, params: params)
      end

      # https://ed.link/docs/api/v2.0/courses/graph-get-course
      def find(id:, params: {})
        path = "/courses/#{id}"
        request(method: :get, path: path, params: params)
      end
    end
  end
end