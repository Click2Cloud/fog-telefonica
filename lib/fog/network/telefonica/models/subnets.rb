require 'fog/telefonica/models/collection'
require 'fog/network/telefonica/models/subnet'

module Fog
  module Network
    class Telefonica
      class Subnets < Fog::Telefonica::Collection
        attribute :filters

        model Fog::Network::Telefonica::Subnet

        def initialize(attributes)
          self.filters ||= {}
          super
        end

        def all(filters_arg = filters)
          filters = filters_arg
          load_response(service.list_subnets(filters), 'subnets')
        end

        def get(subnet_id)
          if subnet = service.get_subnet(subnet_id).body['subnet']
            new(subnet)
          end
        rescue Fog::Network::Telefonica::NotFound
          nil
        end
      end
    end
  end
end
