require 'fog/telefonica/models/collection'
require 'fog/network/telefonica/models/network'

module Fog
  module Network
    class Telefonica
      class Networks < Fog::Telefonica::Collection
        attribute :filters

        model Fog::Network::Telefonica::Network

        def initialize(attributes)
          self.filters ||= {}
          super
        end

        def all(filters_arg = filters)
          filters = filters_arg
          load_response(service.list_networks(filters), 'networks')
        end

        def get(network_id)
          if network = service.get_network(network_id).body['network']
            new(network)
          end
        rescue Fog::Network::Telefonica::NotFound
          nil
        end
      end
    end
  end
end
