module Fog
  module Workflow
    class Telefonica < Fog::Service
      # Fog::Workflow::Telefonica.new() will return a Fog::Workflow::Telefonica::V2
      #  Will choose the latest available once Mistral V3 is released.
      def self.new(args = {})
        @telefonica_auth_uri = URI.parse(args[:telefonica_auth_url]) if args[:telefonica_auth_url]
        Fog::Workflow::Telefonica::V2.new(args)
      end
    end
  end
end
