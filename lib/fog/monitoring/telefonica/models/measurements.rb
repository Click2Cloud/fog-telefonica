require 'fog/telefonica/models/collection'
require 'fog/monitoring/telefonica/models/measurement'

module Fog
  module Monitoring
    class Telefonica
      class Measurements < Fog::Telefonica::Collection
        model Fog::Monitoring::Telefonica::Measurement

        def find(options = {})
          load_response(service.find_measurements(options), 'elements')
        end
      end
    end
  end
end
