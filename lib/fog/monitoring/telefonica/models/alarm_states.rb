require 'fog/telefonica/models/collection'
require 'fog/monitoring/telefonica/models/alarm_state'

module Fog
  module Monitoring
    class Telefonica
      class AlarmStates < Fog::Telefonica::Collection
        model Fog::Monitoring::Telefonica::AlarmState

        def all(options = {})
          load_response(service.list_alarm_state_history_for_all_alarms(options), 'elements')
        end

        def list_alarm_state_history(id, options = {})
          load_response(service.list_alarm_state_history_for_specific_alarm(id, options), 'elements')
        end
      end
    end
  end
end
