require 'fog/telefonica/models/model'

module Fog
  module Compute
    class Telefonica
      class AvailabilityZone < Fog::Telefonica::Model
        identity :zoneName

        attribute :hosts
        attribute :zoneLabel
        attribute :zoneState

        def to_s
          zoneName
        end
      end
    end
  end
end
