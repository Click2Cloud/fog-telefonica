module Fog
  module DNS
    class Telefonica < Fog::Service
      autoload :V1, 'fog/dns/telefonica/v1'
      autoload :V2, 'fog/dns/telefonica/v2'

      # Fog::DNS::Telefonica.new() will return a Fog::DNS::Telefonica::V2 or a Fog::DNS::Telefonica::V1,
      # choosing the latest available
      def self.new(args = {})
        @telefonica_auth_uri = URI.parse(args[:telefonica_auth_url]) if args[:telefonica_auth_url]
        if inspect == 'Fog::DNS::Telefonica'
          service = Fog::DNS::Telefonica::V2.new(args) unless args.empty?
          service ||= Fog::DNS::Telefonica::V1.new(args)
        else
          service = Fog::Service.new(args)
        end
        service
      end
    end
  end
end
