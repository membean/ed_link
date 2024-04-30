# frozen_string_literal: true

module EdLink
  class Course < Base
    
    class << self
      # https://ed.link/docs/api/v2.0/courses/graph-list-courses
      def all(filter: {})
        path = '/courses'
        request(method: :get, path: path, filter: filter)
      end

      # https://ed.link/docs/api/v2.0/courses/graph-list-classes
      def classes(id:, filter: {})
        path = "/courses/#{id}/classes"
        request(method: :get, path: path, filter: filter)
      end

      # https://ed.link/docs/api/v2.0/courses/graph-get-course
      def find(id:)
        path = "/courses/#{id}"
        request(method: :get, path: path)
      end
    end
  end
end