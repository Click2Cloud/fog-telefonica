require 'fog/telefonica/models/collection'
require 'fog/volume/telefonica/v1/models/volume'
require 'fog/volume/telefonica/models/volumes'

module Fog
  module Volume
    class Telefonica
      class V1
        class Volumes < Fog::Telefonica::Collection
          model Fog::Volume::Telefonica::V1::Volume
          include Fog::Volume::Telefonica::Volumes
        end
      end
    end
  end
end
