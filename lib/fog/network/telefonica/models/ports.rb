require 'fog/telefonica/models/collection'
require 'fog/network/telefonica/models/port'

module Fog
  module Network
    class Telefonica
      class Ports < Fog::Telefonica::Collection
        attribute :filters

        model Fog::Network::Telefonica::Port

        def initialize(attributes)
          self.filters ||= {}
          super
        end

        def all(filters_arg = filters)
          filters = filters_arg
          load_response(service.list_ports(filters), 'ports')
        end

        def get(port_id)
          if port = service.get_port(port_id).body['port']
            new(port)
          end
        rescue Fog::Network::Telefonica::NotFound
          nil
        end
      end
    end
  end
end
