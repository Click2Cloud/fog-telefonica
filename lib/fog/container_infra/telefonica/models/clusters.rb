require 'fog/telefonica/models/collection'
require 'fog/container_infra/telefonica/models/cluster'

module Fog
  module ContainerInfra
    class Telefonica
      class Clusters < Fog::Telefonica::Collection

        model Fog::ContainerInfra::Telefonica::Cluster

        def all
          load_response(service.list_clusters, "clusters")
        end

        def get(cluster_uuid_or_name)
          resource = service.get_cluster(cluster_uuid_or_name).body
          new(resource)
        rescue Fog::ContainerInfra::Telefonica::NotFound
          nil
        end
      end
    end
  end
end
