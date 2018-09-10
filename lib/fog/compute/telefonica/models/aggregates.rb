require 'fog/telefonica/models/collection'
require 'fog/compute/telefonica/models/aggregate'

module Fog
  module Compute
    class Telefonica
      class Aggregates < Fog::Telefonica::Collection
        model Fog::Compute::Telefonica::Aggregate

        def all(options = {})
          load_response(service.list_aggregates(options), 'aggregates')
        end

        def find_by_id(id)
          new(service.get_aggregate(id).body['aggregate'])
        end
        alias get find_by_id

        def destroy(id)
          aggregate = find_by_id(id)
          aggregate.destroy
        end
      end
    end
  end
end
