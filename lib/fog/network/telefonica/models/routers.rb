require 'fog/telefonica/models/collection'
require 'fog/network/telefonica/models/router'

module Fog
  module Network
    class Telefonica
      class Routers < Fog::Telefonica::Collection
        attribute :filters

        model Fog::Network::Telefonica::Router

        def initialize(attributes)
          self.filters ||= {}
          super
        end

        def all(filters_arg = filters)
          filters = filters_arg
          load_response(service.list_routers(filters), 'routers')
        end

        def get(router_id)
          if router = service.get_router(router_id).body['router']
            new(router)
          end
        rescue Fog::Network::Telefonica::NotFound
          nil
        end
      end
    end
  end
end
