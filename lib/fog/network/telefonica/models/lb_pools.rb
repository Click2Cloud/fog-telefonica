require 'fog/telefonica/models/collection'
require 'fog/network/telefonica/models/lb_pool'

module Fog
  module Network
    class Telefonica
      class LbPools < Fog::Telefonica::Collection
        attribute :filters

        model Fog::Network::Telefonica::LbPool

        def initialize(attributes)
          self.filters ||= {}
          super
        end

        def all(filters_arg = filters)
          filters = filters_arg
          load_response(service.list_lb_pools(filters), 'pools')
        end

        def get(pool_id)
          if pool = service.get_lb_pool(pool_id).body['pool']
            new(pool)
          end
        rescue Fog::Network::Telefonica::NotFound
          nil
        end
      end
    end
  end
end
