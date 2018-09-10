require 'fog/telefonica/models/collection'
require 'fog/volume/telefonica/v2/models/volume'
require 'fog/volume/telefonica/models/volumes'

module Fog
  module Volume
    class Telefonica
      class V2
        class Volumes < Fog::Telefonica::Collection
          model Fog::Volume::Telefonica::V2::Volume
          include Fog::Volume::Telefonica::Volumes
        end
      end
    end
  end
end
