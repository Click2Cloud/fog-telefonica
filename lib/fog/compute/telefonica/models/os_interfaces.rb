require 'fog/telefonica/models/collection'
require 'fog/compute/telefonica/models/os_interface'

module Fog
  module Compute
    class Telefonica
      class OsInterfaces < Fog::Telefonica::Collection
        model Fog::Compute::Telefonica::OsInterface

        attribute :server

        def all
          requires :server

          data = service.list_os_interfaces(server.id)
          load_response(data, 'interfaceAttachments')
        end

        def get(port_id)
          requires :server

          data = service.get_os_interface(server.id,port_id)
          load_response(data, 'interfaceAttachment')
        end
      end
    end
  end
end
