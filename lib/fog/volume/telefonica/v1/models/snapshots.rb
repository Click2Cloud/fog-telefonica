require 'fog/telefonica/models/collection'
require 'fog/volume/telefonica/v1/models/snapshot'
require 'fog/volume/telefonica/models/snapshots'

module Fog
  module Volume
    class Telefonica
      class V1
        class Snapshots < Fog::Telefonica::Collection
          model Fog::Volume::Telefonica::V1::Snapshot
          include Fog::Volume::Telefonica::Snapshots
        end
      end
    end
  end
end
