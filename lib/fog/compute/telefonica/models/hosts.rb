require 'fog/telefonica/models/collection'
require 'fog/compute/telefonica/models/host'

module Fog
  module Compute
    class Telefonica
      class Hosts < Fog::Telefonica::Collection
        model Fog::Compute::Telefonica::Host

        def all(options = {})
          data = service.list_hosts(options)
          load_response(data, 'hosts')
        end

        def get(host_name)
          if host = service.get_host_details(host_name).body['host']
            new('host_name' => host_name,
                'details'   => host)
          end
        rescue Fog::Compute::Telefonica::NotFound
          nil
        end
      end
    end
  end
end
