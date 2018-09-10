require 'fog/telefonica/models/collection'
require 'fog/compute/telefonica/models/security_group_rule'

module Fog
  module Compute
    class Telefonica
      class SecurityGroupRules < Fog::Telefonica::Collection
        model Fog::Compute::Telefonica::SecurityGroupRule

        def get(security_group_rule_id)
          if security_group_rule_id
            body = service.get_security_group_rule(security_group_rule_id).body
            new(body['security_group_rule'])
          end
        rescue Fog::Compute::Telefonica::NotFound
          nil
        end
      end
    end
  end
end
