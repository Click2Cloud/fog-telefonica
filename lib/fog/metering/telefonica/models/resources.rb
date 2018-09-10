require 'fog/telefonica/models/collection'
require 'fog/metering/telefonica/models/resource'

module Fog
  module Metering
    class Telefonica
      class Resources < Fog::Telefonica::Collection
        model Fog::Metering::Telefonica::Resource

        def all(_detailed = true)
          load_response(service.list_resources)
        end

        def find_by_id(resource_id)
          resource = service.get_resource(resource_id).body
          new(resource)
        rescue Fog::Metering::Telefonica::NotFound
          nil
        end
      end
    end
  end
end
