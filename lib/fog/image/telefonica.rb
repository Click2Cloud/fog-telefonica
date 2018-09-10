

module Fog
  module Image
    class Telefonica < Fog::Service
      autoload :V1, 'fog/image/telefonica/v1'
      autoload :V2, 'fog/image/telefonica/v2'

      # Fog::Image::Telefonica.new() will return a Fog::Image::Telefonica::V2 or a Fog::Image::Telefonica::V1,
      #  choosing the latest available
      def self.new(args = {})
        @telefonica_auth_uri = URI.parse(args[:telefonica_auth_url]) if args[:telefonica_auth_url]
        if inspect == 'Fog::Image::Telefonica'
          service = Fog::Image::Telefonica::V2.new(args) unless args.empty?
          service ||= Fog::Image::Telefonica::V1.new(args)
        else
          service = Fog::Service.new(args)
        end
        service
      end
    end
  end
end
