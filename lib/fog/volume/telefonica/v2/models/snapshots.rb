require 'fog/telefonica/models/collection'
require 'fog/volume/telefonica/v2/models/snapshot'
require 'fog/volume/telefonica/models/snapshots'

module Fog
  module Volume
    class Telefonica
      class V2
        class Snapshots < Fog::Telefonica::Collection
          model Fog::Volume::Telefonica::V2::Snapshot
          include Fog::Volume::Telefonica::Snapshots
        end
      end
    end
  end
end
