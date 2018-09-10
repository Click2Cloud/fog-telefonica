require 'fog/telefonica/models/collection'
require 'fog/compute/telefonica/models/snapshot'

module Fog
  module Compute
    class Telefonica
      class Snapshots < Fog::Telefonica::Collection
        model Fog::Compute::Telefonica::Snapshot

        def all(options = {})
          if !options.kind_of?(Hash)
            if options
              Fog::Logger.deprecation('Calling Telefonica[:compute].snapshots.all(true) is deprecated, use .snapshots.all')
            else
              Fog::Logger.deprecation('Calling Telefonica[:compute].snapshots.all(false) is deprecated, use .snapshots.summary')
            end
            load_response(service.list_snapshots(options), 'snapshots')
          else
            load_response(service.list_snapshots_detail(options), 'snapshots')
          end
        end

        def summary(options = {})
          load_response(service.list_snapshots(options), 'snapshots')
        end

        def get(snapshot_id)
          if snapshot = service.get_snapshot_details(snapshot_id).body['snapshot']
            new(snapshot)
          end
        rescue Fog::Compute::Telefonica::NotFound
          nil
        end
      end
    end
  end
end
