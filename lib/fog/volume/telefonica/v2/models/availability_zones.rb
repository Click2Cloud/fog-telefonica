require 'fog/telefonica/models/collection'
require 'fog/volume/telefonica/v2/models/availability_zone'
require 'fog/volume/telefonica/models/availability_zones'

module Fog
  module Volume
    class Telefonica
      class V2
        class AvailabilityZones < Fog::Telefonica::Collection
          model Fog::Volume::Telefonica::V2::AvailabilityZone
          include Fog::Volume::Telefonica::AvailabilityZones
        end
      end
    end
  end
end
