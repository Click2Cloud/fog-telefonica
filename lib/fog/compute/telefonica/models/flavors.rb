require 'fog/telefonica/models/collection'
require 'fog/compute/telefonica/models/flavor'

module Fog
  module Compute
    class Telefonica
      class Flavors < Fog::Telefonica::Collection
        model Fog::Compute::Telefonica::Flavor

        def all(options = {})
          data = service.list_flavors_detail(options)
          load_response(data, 'flavors')
        end

        def summary(options = {})
          data = service.list_flavors(options)
          load_response(data, 'flavors')
        end

        def get(flavor_id)
          data = service.get_flavor_details(flavor_id).body['flavor']
          new(data)
        rescue Fog::Compute::Telefonica::NotFound
          nil
        end
      end
    end
  end
end
