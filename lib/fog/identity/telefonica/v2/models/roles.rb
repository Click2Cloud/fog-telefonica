require 'fog/telefonica/models/collection'
require 'fog/identity/telefonica/v2/models/role'

module Fog
  module Identity
    class Telefonica
      class V2
        class Roles < Fog::Telefonica::Collection
          model Fog::Identity::Telefonica::V2::Role

          def all(options = {})
            load_response(service.list_roles(options), 'roles')
          end

          def get(id)
            service.get_role(id)
          end
        end
      end
    end
  end
end
