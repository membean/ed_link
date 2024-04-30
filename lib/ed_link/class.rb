# frozen_string_literal: true

module EdLink
  class Class < Base
    
    class << self
      # https://ed.link/docs/api/v2.0/classes/graph-list-classes
      def all(filter: {})
        path = '/classes'
        request(method: :get, path: path, filter: filter)
      end

      # https://ed.link/docs/api/v2.0/classes/graph-list-enrollments
      def enrollments(id:, filter: {})
        path = "/classes/#{id}/enrollments"
        request(method: :get, path: path, filter: filter)
      end

      # https://ed.link/docs/api/v2.0/classes/graph-get-class
      def find(id:)
        path = "/classes/#{id}"
        request(method: :get, path: path)
      end

      # https://ed.link/docs/api/v2.0/classes/graph-get-meeting
      def meeting(class_id:, meeting_id:)
        path = "/classes/#{class_id}/meetings/#{meeting_id}"
        request(method: :get, path: path)
      end

      # https://ed.link/docs/api/v2.0/classes/graph-list-meetings
      def meetings(id:)
        path = "/classes/#{id}/meetings"
        request(method: :get, path: path)
      end

      # https://ed.link/docs/api/v2.0/classes/graph-list-people
      def people(id:, filter: {})
        path = "/classes/#{id}/people"
        request(method: :get, path: path, filter: filter)
      end

      # https://ed.link/docs/api/v2.0/classes/graph-list-sections
      def sections(id:, filter: {})
        path = "/classes/#{id}/sections"
        request(method: :get, path: path, filter: filter)
      end

      # https://ed.link/docs/api/v2.0/classes/graph-list-students
      def students(id:, filter: {})
        path = "/classes/#{id}/students"
        request(method: :get, path: path, filter: filter)
      end

      # https://ed.link/docs/api/v2.0/classes/graph-list-teachers
      def teachers(id:, filter: {})
        path = "/classes/#{id}/teachers"
        request(method: :get, path: path, filter: filter)
      end
      
    end
  end
end