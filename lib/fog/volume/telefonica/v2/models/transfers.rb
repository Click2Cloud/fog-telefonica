require 'fog/telefonica/models/collection'
require 'fog/volume/telefonica/v2/models/transfer'
require 'fog/volume/telefonica/models/transfers'

module Fog
  module Volume
    class Telefonica
      class V2
        class Transfers < Fog::Telefonica::Collection
          model Fog::Volume::Telefonica::V2::Transfer
          include Fog::Volume::Telefonica::Transfers
        end
      end
    end
  end
end
