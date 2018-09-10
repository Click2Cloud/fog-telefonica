require 'fog/telefonica/models/collection'
require 'fog/volume/telefonica/v1/models/volume_type'
require 'fog/volume/telefonica/models/volume_types'

module Fog
  module Volume
    class Telefonica
      class V1
        class VolumeTypes < Fog::Telefonica::Collection
          model Fog::Volume::Telefonica::V1::VolumeType
          include Fog::Volume::Telefonica::VolumeTypes
        end
      end
    end
  end
end
