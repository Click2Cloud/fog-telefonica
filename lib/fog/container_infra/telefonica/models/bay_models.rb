require 'fog/telefonica/models/collection'
require 'fog/container_infra/telefonica/models/bay_model'

module Fog
  module ContainerInfra
    class Telefonica
      class BayModels < Fog::Telefonica::Collection
        model Fog::ContainerInfra::Telefonica::BayModel

        def all
          load_response(service.list_bay_models, 'baymodels')
        end

        def get(bay_model_uuid_or_name)
          resource = service.get_bay_model(bay_model_uuid_or_name).body
          new(resource)
        rescue Fog::ContainerInfra::Telefonica::NotFound
          nil
        end
      end
    end
  end
end
