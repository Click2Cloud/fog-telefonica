require 'fog/telefonica/models/collection'
require 'fog/orchestration/telefonica/models/event'

module Fog
  module Orchestration
    class Telefonica
      class Events < Fog::Telefonica::Collection
        model Fog::Orchestration::Telefonica::Event

        def all(options = {}, options_deprecated = {})
          data = if options.kind_of?(Stack)
                   service.list_stack_events(options, options_deprecated)
                 elsif options.kind_of?(Hash)
                   service.list_events(options)
                 else
                   service.list_resource_events(options.stack, options, options_deprecated)
                 end

          load_response(data, 'events')
        end

        def get(stack, resource, event_id)
          data = service.show_event_details(stack, resource, event_id).body['event']
          new(data)
        rescue Fog::Compute::Telefonica::NotFound
          nil
        end
      end
    end
  end
end
