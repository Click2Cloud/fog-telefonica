require 'fog/telefonica/models/collection'
require 'fog/shared_file_system/telefonica/models/availability_zone'

module Fog
  module SharedFileSystem
    class Telefonica
      class AvailabilityZones < Fog::Telefonica::Collection
        model Fog::SharedFileSystem::Telefonica::AvailabilityZone

        def all
          load_response(service.list_availability_zones(), 'availability_zones')
        end
      end
    end
  end
end
