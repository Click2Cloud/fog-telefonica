require 'fog/telefonica/models/model'

module Fog
  module Monitoring
    class Telefonica
      class AlarmState < Fog::Telefonica::Model
        identity :id

        attribute :alarm_id
        attribute :metrics
        attribute :old_state
        attribute :new_state
        attribute :reason
        attribute :reason_data
        attribute :timestamp
        attribute :sub_alarms

        def patch(options)
          requires :id
          merge_attributes(
            service.list_alarm_state_history_for_specific_alarm(id, options)
          )
          self
        end

        def to_s
          name
        end
      end
    end
  end
end
