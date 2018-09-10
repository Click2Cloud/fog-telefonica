require 'fog/telefonica/models/collection'

module Fog
  module Volume
    class Telefonica
      module Snapshots
        def all(options = {})
          load_response(service.list_snapshots_detailed(options), 'snapshots')
        end

        def summary(options = {})
          load_response(service.list_snapshots(options), 'snapshots')
        end

        def get(snapshots_id)
          snapshot = service.get_snapshot_details(snapshots_id).body['snapshot']
          if snapshot
            new(snapshot)
          end
        rescue Fog::Volume::Telefonica::NotFound
          nil
        end
      end
    end
  end
end
