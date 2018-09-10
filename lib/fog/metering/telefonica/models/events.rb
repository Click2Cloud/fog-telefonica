require 'fog/telefonica/models/collection'
require 'fog/metering/telefonica/models/event'

module Fog
  module Metering
    class Telefonica
      class Events < Fog::Telefonica::Collection
        model Fog::Metering::Telefonica::Event

        def all(q = [])
          load_response(service.list_events(q))
        end

        def find_by_id(message_id)
          event = service.get_event(message_id).body
          new(event)
        rescue Fog::Metering::Telefonica::NotFound
          nil
        end
      end
    end
  end
end
