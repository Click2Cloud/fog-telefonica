require 'fog/telefonica/models/model'

module Fog
  module DNS
    class Telefonica
      class V2
        class ZoneTransferAccept < Fog::Telefonica::Model
          identity :id

          attribute :status
          attribute :project_id
          attribute :zone_id
          attribute :key
          attribute :created_at
          attribute :updated_at
          attribute :zone_transfer_request_id
          attribute :links

          def save
            unless persisted?
              merge_attributes(service.create_zone_transfer_accept(key, zone_transfer_request_id))
            end
            true
          end
        end
      end
    end
  end
end
