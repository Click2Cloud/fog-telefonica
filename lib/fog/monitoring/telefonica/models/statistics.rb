require 'fog/telefonica/models/collection'
require 'fog/monitoring/telefonica/models/statistic'

module Fog
  module Monitoring
    class Telefonica
      class Statistics < Fog::Telefonica::Collection
        model Fog::Monitoring::Telefonica::Statistic

        def all(options = {})
          load_response(service.list_statistics(options), 'elements')
        end
      end
    end
  end
end
