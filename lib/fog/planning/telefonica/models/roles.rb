require 'fog/telefonica/models/collection'
require 'fog/planning/telefonica/models/role'

module Fog
  module Telefonica
    class Planning
      class Roles < Fog::Telefonica::Collection
        model Fog::Telefonica::Planning::Role

        def all(options = {})
          load_response(service.list_roles(options))
        end
      end
    end
  end
end
