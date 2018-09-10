require 'fog/telefonica/models/collection'
require 'fog/volume/telefonica/v1/models/transfer'
require 'fog/volume/telefonica/models/transfers'

module Fog
  module Volume
    class Telefonica
      class V1
        class Transfers < Fog::Telefonica::Collection
          model Fog::Volume::Telefonica::V1::Transfer
          include Fog::Volume::Telefonica::Transfers
        end
      end
    end
  end
end
