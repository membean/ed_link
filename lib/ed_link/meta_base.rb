# frozen_string_literal: true

module EdLink
  class MetaBase < Base
    base_uri 'https://ed.link/api/v1'

    class << self

      private

      def auth_headers(_)
        app_secret = EdLink.configuration.app_secret
        { 'Authorization': "Bearer #{app_secret}" }
      end
    end
  end
end
