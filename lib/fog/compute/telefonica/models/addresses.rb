require 'fog/telefonica/models/collection'
require 'fog/compute/telefonica/models/address'

module Fog
  module Compute
    class Telefonica
      class Addresses < Fog::Telefonica::Collection
        model Fog::Compute::Telefonica::Address

        def all(options = {})
          load_response(service.list_all_addresses(options), 'floating_ips')
        end

        def get(address_id)
          if address = service.get_address(address_id).body['floating_ip']
            new(address)
          end
        rescue Fog::Compute::Telefonica::NotFound
          nil
        end

        def get_address_pools
          service.list_address_pools.body['floating_ip_pools']
        end
      end
    end
  end
end
