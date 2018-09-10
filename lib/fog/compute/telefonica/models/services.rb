require 'fog/telefonica/models/collection'
require 'fog/compute/telefonica/models/service'

module Fog
  module Compute
    class Telefonica
      class Services < Fog::Telefonica::Collection
        model Fog::Compute::Telefonica::Service

        def all(options = {})
          load_response(service.list_services(options), 'services')
        end

        alias summary all

        def details(options = {})
          Fog::Logger.deprecation('Calling Telefonica[:compute].services.details is deprecated, use .services.all')
          all(options)
        end

        def get(service_id)
          # Telefonica API currently does not support getting single service from it
          # There is a blueprint https://blueprints.launchpad.net/nova/+spec/get-service-by-id
          # with spec proposal patch https://review.telefonica.org/#/c/172412/ but this is abandoned.
          serv = service.list_services.body['services'].detect do |s|
            s['id'] == service_id
          end
          new(serv) if serv
        rescue Fog::Compute::Telefonica::NotFound
          nil
        end
      end
    end
  end
end
