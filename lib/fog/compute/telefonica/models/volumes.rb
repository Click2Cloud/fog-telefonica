require 'fog/telefonica/models/collection'
require 'fog/compute/telefonica/models/volume'

module Fog
  module Compute
    class Telefonica
      class Volumes < Fog::Telefonica::Collection
        model Fog::Compute::Telefonica::Volume

        def all(options = true)
          if !options.kind_of?(Hash)
            if options
              Fog::Logger.deprecation('Calling Telefonica[:compute].volumes.all(true) is deprecated, use .volumes.all')
            else
              Fog::Logger.deprecation('Calling Telefonica[:compute].volumes.all(false) is deprecated, use .volumes.summary')
            end
            load_response(service.list_volumes(options), 'volumes')
          else
            load_response(service.list_volumes_detail(options), 'volumes')
          end
        end

        def summary(options = {})
          load_response(service.list_volumes(options), 'volumes')
        end

        def get(volume_id)
          if volume = service.get_volume_details(volume_id).body['volume']
            new(volume)
          end
        rescue Fog::Compute::Telefonica::NotFound
          nil
        end
      end
    end
  end
end
