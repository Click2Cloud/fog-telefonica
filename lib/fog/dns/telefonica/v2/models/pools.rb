require 'fog/telefonica/models/collection'
require 'fog/dns/telefonica/v2/models/pool'

module Fog
  module DNS
    class Telefonica
      class V2
        class Pools < Fog::Telefonica::Collection
          model Fog::DNS::Telefonica::V2::Pool

          def all(options = {})
            load_response(service.list_pools(options), 'pools')
          end

          def find_by_id(id, options = {})
            pool_hash = service.get_pool(id, options).body
            new(pool_hash.merge(:service => service))
          end

          alias get find_by_id
        end
      end
    end
  end
end
