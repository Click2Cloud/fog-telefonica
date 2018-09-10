require 'fog/telefonica/models/collection'
require 'fog/network/telefonica/models/security_group'

module Fog
  module Network
    class Telefonica
      class SecurityGroups < Fog::Telefonica::Collection
        attribute :filters

        model Fog::Network::Telefonica::SecurityGroup

        def initialize(attributes)
          self.filters ||= {}
          super
        end

        def all(filters_arg = filters)
          filters = filters_arg
          load_response(service.list_security_groups(filters), 'security_groups')
        end

        def get(security_group_id)
          if security_group = service.get_security_group(security_group_id).body['security_group']
            new(security_group)
          end
        rescue Fog::Network::Telefonica::NotFound
          nil
        end
      end
    end
  end
end
