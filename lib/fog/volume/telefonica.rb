

module Fog
  module Volume
    class Telefonica < Fog::Service
      autoload :V1, 'fog/volume/telefonica/v1'
      autoload :V2, 'fog/volume/telefonica/v2'

      @@recognizes = [:telefonica_auth_token, :telefonica_management_url,
                      :persistent, :telefonica_service_type, :telefonica_service_name,
                      :telefonica_tenant, :telefonica_tenant_id,
                      :telefonica_api_key, :telefonica_username, :telefonica_identity_endpoint,
                      :current_user, :current_tenant, :telefonica_region,
                      :telefonica_endpoint_type, :telefonica_cache_ttl,
                      :telefonica_project_name, :telefonica_project_id,
                      :telefonica_project_domain, :telefonica_user_domain, :telefonica_domain_name,
                      :telefonica_project_domain_id, :telefonica_user_domain_id, :telefonica_domain_id,
                      :telefonica_identity_prefix]

      # Fog::Image::Telefonica.new() will return a Fog::Volume::Telefonica::V2 or a Fog::Volume::Telefonica::V1,
      #  choosing the V2 by default, as V1 is deprecated since Telefonica Juno
      def self.new(args = {})
        @telefonica_auth_uri = URI.parse(args[:telefonica_auth_url]) if args[:telefonica_auth_url]
        service = if inspect == 'Fog::Volume::Telefonica'
                    Fog::Volume::Telefonica::V2.new(args) || Fog::Volume::Telefonica::V1.new(args)
                  else
                    super
                  end
        service
      end
    end
  end
end
