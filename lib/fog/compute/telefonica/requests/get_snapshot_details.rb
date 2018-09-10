module Fog
  module Compute
    class Telefonica
      class Real
        def get_snapshot_details(snapshot_id)
          request(
            :expects => 200,
            :method  => 'GET',
            :path    => "os-snapshots/#{snapshot_id}"
          )
        end
      end

      class Mock
        def get_snapshot_details(snapshot_id)
          response = Excon::Response.new
          if snapshot = list_snapshots_detail.body['snapshots'].find do |snap|
            snap['id'] == snapshot_id
          end
            response.status = 200
            response.body = {'snapshot' => snapshot}
            response
          else
            raise Fog::Compute::Telefonica::NotFound
          end
        end
      end
    end
  end
end
