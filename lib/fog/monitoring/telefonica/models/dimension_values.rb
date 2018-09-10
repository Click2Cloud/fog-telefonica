require 'fog/telefonica/models/collection'
require 'fog/monitoring/telefonica/models/dimension_value'

module Fog
  module Monitoring
    class Telefonica
      class DimensionValues < Fog::Telefonica::Collection
        model Fog::Monitoring::Telefonica::DimensionValue

        def all(dimension_name, options = {})
          load_response(service.list_dimension_values(dimension_name, options), 'elements')
        end
      end
    end
  end
end
