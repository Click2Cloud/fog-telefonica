require 'fog/volume/telefonica/models/volume_type'

module Fog
  module Volume
    class Telefonica
      class V1
        class VolumeType < Fog::Volume::Telefonica::VolumeType
          identity :id

          attribute :name
          attribute :volume_backend_name
        end
      end
    end
  end
end
