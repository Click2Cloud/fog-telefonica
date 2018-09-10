require 'fog/telefonica/models/collection'
require 'fog/monitoring/telefonica/models/alarm_count'

module Fog
  module Monitoring
    class Telefonica
      class AlarmCounts < Fog::Telefonica::Collection
        model Fog::Monitoring::Telefonica::AlarmCount

        def get(options = {})
          load_response(service.get_alarm_counts(options))
        end
      end
    end
  end
end
