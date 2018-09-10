require 'fog/telefonica/models/collection'
require 'fog/container_infra/telefonica/models/certificate'

module Fog
  module ContainerInfra
    class Telefonica
      class Certificates < Fog::Telefonica::Collection

        model Fog::ContainerInfra::Telefonica::Certificate

        def create(bay_uuid)
          resource = service.create_certificate(bay_uuid).body
          new(resource)
        end

        def get(bay_uuid)
          resource = service.get_certificate(bay_uuid).body
          new(resource)
        rescue Fog::ContainerInfra::Telefonica::NotFound
          nil
        end
      end
    end
  end
end
