# frozen_string_literal: true

module EdLink
  class Session < Base
    
    class << self
      # https://ed.link/docs/api/v2.0/sessions/graph-list-sessions
      def all(params: {})
        path = '/sessions'
        request(method: :get, path: path, params: params)
      end

      # https://ed.link/docs/api/v2.0/sessions/graph-get-session
      def find(id:, params: {})
        path = "/sessions/#{id}"
        request(method: :get, path: path, params: params)
      end
    end
  end
end