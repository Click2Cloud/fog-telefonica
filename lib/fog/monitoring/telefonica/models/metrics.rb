require 'fog/telefonica/models/collection'
require 'fog/monitoring/telefonica/models/metric'
require 'fog/monitoring/telefonica/models/dimension_values'

module Fog
  module Monitoring
    class Telefonica
      class Metrics < Fog::Telefonica::Collection
        model Fog::Monitoring::Telefonica::Metric

        def all(options = {})
          load_response(service.list_metrics(options), 'elements')
        end

        def list_metric_names(options = {})
          load_response(service.list_metric_names(options), 'elements')
        end

        def create(attributes)
          super(attributes)
        end

        def create_metric_array(metrics_list = [])
          service.create_metric_array(metrics_list)
        end

        def list_dimension_values(dimension_name, options = {})
          dimension_value = Fog::Monitoring::Telefonica::DimensionValues.new
          dimension_value.load_response(
            service.list_dimension_values(dimension_name, options), 'elements'
          )
        end
      end
    end
  end
end
