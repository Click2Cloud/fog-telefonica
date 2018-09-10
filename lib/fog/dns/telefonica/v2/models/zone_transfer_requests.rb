require 'fog/telefonica/models/collection'
require 'fog/dns/telefonica/v2/models/zone_transfer_request'

module Fog
  module DNS
    class Telefonica
      class V2
        class ZoneTransferRequests < Fog::Telefonica::Collection
          model Fog::DNS::Telefonica::V2::ZoneTransferRequest

          def all(options = {})
            load_response(service.list_zone_transfer_requests(options), 'transfer_requests')
          end

          def find_by_id(id)
            zone_transfer_request_hash = service.get_zone_transfer_request(id).body
            new(zone_transfer_request_hash.merge(:service => service))
          end

          alias get find_by_id

          def destroy(id)
            zone = find_by_id(id)
            zone.destroy
          end
        end
      end
    end
  end
end
