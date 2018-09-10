require 'fog/volume/telefonica/models/transfer'

module Fog
  module Volume
    class Telefonica
      class V2
        class Transfer < Fog::Volume::Telefonica::Transfer
          identity :id

          attribute :auth_key, :aliases => 'authKey'
          attribute :created_at, :aliases => 'createdAt'
          attribute :name
          attribute :volume_id, :aliases => 'volumeId'
        end
      end
    end
  end
end
