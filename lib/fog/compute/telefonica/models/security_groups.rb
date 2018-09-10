require 'fog/telefonica/models/collection'
require 'fog/compute/telefonica/models/security_group'

module Fog
  module Compute
    class Telefonica
      class SecurityGroups < Fog::Telefonica::Collection
        model Fog::Compute::Telefonica::SecurityGroup

        def all(options = {})
          load_response(service.list_security_groups(options), 'security_groups')
        end

        def get(security_group_id)
          if security_group_id
            new(service.get_security_group(security_group_id).body['security_group'])
          end
        rescue Fog::Compute::Telefonica::NotFound
          nil
        end
      end
    end
  end
end
