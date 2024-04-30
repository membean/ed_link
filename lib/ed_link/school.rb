# frozen_string_literal: true

module EdLink
  class School < Base
    
    class << self
      # https://ed.link/docs/api/v2.0/schools/graph-list-administrators
      def administrators(id:, filter: {})
        path = "/schools/#{id}/administrators"
        request(method: :get, path: path, filter: filter)
      end

      # https://ed.link/docs/api/v2.0/schools/graph-list-schools
      def all(filter: {})
        path = '/schools'
        request(method: :get, path: path, filter: filter)
      end

      # https://ed.link/docs/api/v2.0/schools/graph-list-classes
      def classes(id:, filter: {})
        path = "/schools/#{id}/classes"
        request(method: :get, path: path, filter: filter)
      end

      # https://ed.link/docs/api/v2.0/schools/graph-list-courses
      def courses(id:, filter: {})
        path = "/schools/#{id}/courses"
        request(method: :get, path: path, filter: filter)
      end

      # https://ed.link/docs/api/v2.0/schools/graph-get-school
      def find(id:)
        path = "/schools/#{id}"
        request(method: :get, path: path)
      end

      # https://ed.link/docs/api/v2.0/schools/graph-list-people
      def people(id:, filter: {})
        path = "/schools/#{id}/people"
        request(method: :get, path: path, filter: filter)
      end

      # https://ed.link/docs/api/v2.0/schools/graph-list-sessions
      def sessions(id:, filter: {})
        path = "/schools/#{id}/sessions"
        request(method: :get, path: path, filter: filter)
      end

      # https://ed.link/docs/api/v2.0/schools/graph-list-students
      def students(id:, filter: {})
        path = "/schools/#{id}/students"
        request(method: :get, path: path, filter: filter)
      end

      # https://ed.link/docs/api/v2.0/schools/graph-list-teachers
      def teachers(id:, filter: {})
        path = "/schools/#{id}/teachers"
        request(method: :get, path: path, filter: filter)
      end
    end
  end
end