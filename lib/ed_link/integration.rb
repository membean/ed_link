# frozen_string_literal: true

module EdLink
  class Integration < MetaBase

    class << self
      # https://ed.link/docs/api/v2.0/integrations/meta-list-integrations
      def all(params: {})
        path = '/integrations'
        request(method: :get, path: path, params: params)
      end

      # https://ed.link/docs/api/v2.0/integrations/meta-get-integration
      def find(id:, params: {})
        path = "/integrations/#{id}"
        request(method: :get, path: path, params: params)
      end
    end
  end
end
