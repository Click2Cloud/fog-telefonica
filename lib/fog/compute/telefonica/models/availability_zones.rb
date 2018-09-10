require 'fog/telefonica/models/collection'
require 'fog/compute/telefonica/models/availability_zone'

module Fog
  module Compute
    class Telefonica
      class AvailabilityZones < Fog::Telefonica::Collection
        model Fog::Compute::Telefonica::AvailabilityZone

        def all(options = {})
          data = service.list_zones_detailed(options)
          load_response(data, 'availabilityZoneInfo')
        end

        def summary(options = {})
          data = service.list_zones(options)
          load_response(data, 'availabilityZoneInfo')
        end
      end
    end
  end
end
