require 'fog/telefonica/models/model'

module Fog
  module Network
    class Telefonica
      class Subnet < Fog::Telefonica::Model
        identity :id

        attribute :name
        attribute :network_id
        attribute :cidr
        attribute :ip_version
        attribute :gateway_ip
        attribute :allocation_pools
        attribute :dns_nameservers
        attribute :host_routes
        attribute :enable_dhcp
        attribute :tenant_id

        def create
          requires :network_id, :cidr, :ip_version
          merge_attributes(service.create_subnet(network_id,
                                                 cidr,
                                                 ip_version,
                                                 attributes).body['subnet'])
          self
        end

        def update
          requires :id
          merge_attributes(service.update_subnet(id,
                                                 attributes).body['subnet'])
          self
        end

        def destroy
          requires :id
          service.delete_subnet(id)
          true
        end
      end
    end
  end
end
