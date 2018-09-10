require 'fog/telefonica/models/collection'

module Fog
  module Orchestration
    class Telefonica
      class ResourceSchemas < Fog::Telefonica::Collection
        def get(resource_type)
          service.show_resource_schema(resource_type).body
        rescue Fog::Compute::Telefonica::NotFound
          nil
        end
      end
    end
  end
end
