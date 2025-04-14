# frozen_string_literal: true

module EdLink
  class School < GraphBase
    
    class << self
      # https://ed.link/docs/api/v2.0/schools/graph-list-administrators
      def administrators(id:, params: {})
        path = "/schools/#{id}/administrators"
        request(method: :get, path: path, params: params)
      end

      # https://ed.link/docs/api/v2.0/schools/graph-list-schools
      def all(params: {})
        path = '/schools'
        request(method: :get, path: path, params: params)
      end

      # https://ed.link/docs/api/v2.0/schools/graph-list-classes
      def classes(id:, params: {})
        path = "/schools/#{id}/classes"
        request(method: :get, path: path, params: params)
      end

      # https://ed.link/docs/api/v2.0/schools/graph-list-courses
      def courses(id:, params: {})
        path = "/schools/#{id}/courses"
        request(method: :get, path: path, params: params)
      end

      # https://ed.link/docs/api/v2.0/schools/graph-get-school
      def find(id:, params: {})
        path = "/schools/#{id}"
        request(method: :get, path: path, params: params)
      end

      # https://ed.link/docs/api/v2.0/schools/graph-list-people
      def people(id:, params: {})
        path = "/schools/#{id}/people"
        request(method: :get, path: path, params: params)
      end

      # https://ed.link/docs/api/v2.0/schools/graph-list-sessions
      def sessions(id:, params: {})
        path = "/schools/#{id}/sessions"
        request(method: :get, path: path, params: params)
      end

      # https://ed.link/docs/api/v2.0/schools/graph-list-students
      def students(id:, params: {})
        path = "/schools/#{id}/students"
        request(method: :get, path: path, params: params)
      end

      # https://ed.link/docs/api/v2.0/schools/graph-list-teachers
      def teachers(id:, params: {})
        path = "/schools/#{id}/teachers"
        request(method: :get, path: path, params: params)
      end
    end
  end
end
