require 'fog/volume/telefonica/models/availability_zone'

module Fog
  module Volume
    class Telefonica
      class V2
        class AvailabilityZone < Fog::Volume::Telefonica::AvailabilityZone
          identity :zoneName

          attribute :zoneState
        end
      end
    end
  end
end
