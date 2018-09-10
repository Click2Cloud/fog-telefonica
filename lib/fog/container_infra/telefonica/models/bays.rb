require 'fog/telefonica/models/collection'
require 'fog/container_infra/telefonica/models/bay'

module Fog
  module ContainerInfra
    class Telefonica
      class Bays < Fog::Telefonica::Collection
        model Fog::ContainerInfra::Telefonica::Bay

        def all
          load_response(service.list_bays, "bays")
        end

        def get(bay_uuid_or_name)
          resource = service.get_bay(bay_uuid_or_name).body
          new(resource)
        rescue Fog::ContainerInfra::Telefonica::NotFound
          nil
        end
      end
    end
  end
end
