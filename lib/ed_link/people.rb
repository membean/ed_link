# frozen_string_literal: true

module EdLink
  class People < Base
    
    class << self
      # https://ed.link/docs/api/v2.0/people/graph-list-agents
      def agents(id:, params: {})
        path = "/people/#{id}/agents"
        request(method: :get, path: path, params: params)
      end

      # https://ed.link/docs/api/v2.0/people/graph-list-people
      def all(params: {})
        path = '/people'
        request(method: :get, path: path, params: params)
      end

      # https://ed.link/docs/api/v2.0/people/graph-list-classes
      def classes(id:, params: {})
        path = "/people/#{id}/classes"
        request(method: :get, path: path, params: params)
      end

      # https://ed.link/docs/api/v2.0/people/graph-list-districts
      def districts(id:, params: {})
        path = "/people/#{id}/districts"
        request(method: :get, path: path, params: params)
      end

      # https://ed.link/docs/api/v2.0/people/graph-list-enrollments
      def enrollments(id:, params: {})
        path = "/people/#{id}/enrollments"
        request(method: :get, path: path, params: params)
      end

      # https://ed.link/docs/api/v2.0/people/graph-get-person
      def find(id:, params: {})
        path = "/people/#{id}"
        request(method: :get, path: path, params: params)
      end

      # https://ed.link/docs/api/v2.0/people/graph-list-schools
      def schools(id:, params: {})
        path = "/people/#{id}/schools"
        request(method: :get, path: path, params: params)
      end
      
      # https://ed.link/docs/api/v2.0/people/graph-list-sections
      def sections(id:, params: {})
        path = "/people/#{id}/sections"
        request(method: :get, path: path, params: params)
      end
    end
  end
end