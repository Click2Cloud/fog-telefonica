require 'fog/telefonica/models/collection'
require 'fog/container_infra/telefonica/models/cluster_template'

module Fog
  module ContainerInfra
    class Telefonica
      class ClusterTemplates < Fog::Telefonica::Collection

        model Fog::ContainerInfra::Telefonica::ClusterTemplate

        def all
          load_response(service.list_cluster_templates, 'clustertemplates')
        end

        def get(cluster_template_uuid_or_name)
          resource = service.get_cluster_template(cluster_template_uuid_or_name).body
          new(resource)
        rescue Fog::ContainerInfra::Telefonica::NotFound
          nil
        end
      end
    end
  end
end
