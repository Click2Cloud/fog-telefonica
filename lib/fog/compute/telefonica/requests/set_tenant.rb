module Fog
  module Compute
    class Telefonica
      class Real
        def set_tenant(tenant)
          @telefonica_must_reauthenticate = true
          @telefonica_tenant = tenant.to_s
          authenticate
        end
      end

      class Mock
        def set_tenant(_tenant)
          true
        end
      end
    end
  end
end
