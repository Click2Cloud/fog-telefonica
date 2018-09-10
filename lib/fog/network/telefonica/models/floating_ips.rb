require 'fog/telefonica/models/collection'
require 'fog/network/telefonica/models/floating_ip'

module Fog
  module Network
    class Telefonica
      class FloatingIps < Fog::Telefonica::Collection
        attribute :filters

        model Fog::Network::Telefonica::FloatingIp

        def initialize(attributes)
          self.filters ||= {}
          super
        end

        def all(filters_arg = filters)
          filters = filters_arg
          load_response(service.list_floating_ips(filters), 'floatingips')
        end

        def get(floating_network_id)
          if floating_ip = service.get_floating_ip(floating_network_id).body['floatingip']
            new(floating_ip)
          end
        rescue Fog::Network::Telefonica::NotFound
          nil
        end
      end
    end
  end
end
