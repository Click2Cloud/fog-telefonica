require 'fog/telefonica/models/collection'
require 'fog/volume/telefonica/v1/models/availability_zone'
require 'fog/volume/telefonica/models/availability_zones'

module Fog
  module Volume
    class Telefonica
      class V1
        class AvailabilityZones < Fog::Telefonica::Collection
          model Fog::Volume::Telefonica::V1::AvailabilityZone
          include Fog::Volume::Telefonica::AvailabilityZones
        end
      end
    end
  end
end
