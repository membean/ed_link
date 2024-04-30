# frozen_string_literal: true

module EdLink
  class Class < Base
    
    class << self
      # https://ed.link/docs/api/v2.0/classes/graph-list-classes
      def all(params: {})
        path = '/classes'
        request(method: :get, path: path, params: params)
      end

      # https://ed.link/docs/api/v2.0/classes/graph-list-enrollments
      def enrollments(id:, params: {})
        path = "/classes/#{id}/enrollments"
        request(method: :get, path: path, params: params)
      end

      # https://ed.link/docs/api/v2.0/classes/graph-get-class
      def find(id:, params: {})
        path = "/classes/#{id}"
        request(method: :get, path: path, params: params)
      end

      # https://ed.link/docs/api/v2.0/classes/graph-get-meeting
      def meeting(class_id:, meeting_id:, params: {})
        path = "/classes/#{class_id}/meetings/#{meeting_id}"
        request(method: :get, path: path, params: params)
      end

      # https://ed.link/docs/api/v2.0/classes/graph-list-meetings
      def meetings(id:, params: {})
        path = "/classes/#{id}/meetings"
        request(method: :get, path: path, params: params)
      end

      # https://ed.link/docs/api/v2.0/classes/graph-list-people
      def people(id:, params: {})
        path = "/classes/#{id}/people"
        request(method: :get, path: path, params: params)
      end

      # https://ed.link/docs/api/v2.0/classes/graph-list-sections
      def sections(id:, params: {})
        path = "/classes/#{id}/sections"
        request(method: :get, path: path, params: params)
      end

      # https://ed.link/docs/api/v2.0/classes/graph-list-students
      def students(id:, params: {})
        path = "/classes/#{id}/students"
        request(method: :get, path: path, params: params)
      end

      # https://ed.link/docs/api/v2.0/classes/graph-list-teachers
      def teachers(id:, params: {})
        path = "/classes/#{id}/teachers"
        request(method: :get, path: path, params: params)
      end
      
    end
  end
end