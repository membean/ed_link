# frozen_string_literal: true

module EdLink
  class People < Base
    
    class << self
      # https://ed.link/docs/api/v2.0/people/graph-list-agents
      def agents(id:, filter: {})
        path = "/people/#{id}/agents"
        request(method: :get, path: path, filter: filter)
      end

      # https://ed.link/docs/api/v2.0/people/graph-list-people
      def all(filter: {})
        path = '/people'
        request(method: :get, path: path, filter: filter)
      end

      # https://ed.link/docs/api/v2.0/people/graph-list-classes
      def classes(id:, filter: {})
        path = "/people/#{id}/classes"
        request(method: :get, path: path, filter: filter)
      end

      # https://ed.link/docs/api/v2.0/people/graph-list-districts
      def districts(id:, filter: {})
        path = "/people/#{id}/districts"
        request(method: :get, path: path, filter: filter)
      end

      # https://ed.link/docs/api/v2.0/people/graph-list-enrollments
      def enrollments(id:, filter: {})
        path = "/people/#{id}/enrollments"
        request(method: :get, path: path, filter: filter)
      end

      # https://ed.link/docs/api/v2.0/people/graph-get-person
      def find(id:)
        path = "/people/#{id}"
        request(method: :get, path: path)
      end

      # https://ed.link/docs/api/v2.0/people/graph-list-schools
      def schools(id:, filter: {})
        path = "/people/#{id}/schools"
        request(method: :get, path: path, filter: filter)
      end
      
      # https://ed.link/docs/api/v2.0/people/graph-list-sections
      def sections(id:, filter: {})
        path = "/people/#{id}/sections"
        request(method: :get, path: path, filter: filter)
      end
    end
  end
end