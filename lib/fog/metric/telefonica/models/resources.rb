require 'fog/telefonica/models/collection'
require 'fog/metric/telefonica/models/resource'

module Fog
  module Metric
    class Telefonica
      class Resources < Fog::Telefonica::Collection

        model Fog::Metric::Telefonica::Resource

        def all(options = {})
          load_response(service.list_resources(options))
        end

        def find_by_id(resource_id)
          resource = service.get_resource(resource_id).body
          new(resource)
        rescue Fog::Metric::Telefonica::NotFound
          nil
        end
      end
    end
  end
end
