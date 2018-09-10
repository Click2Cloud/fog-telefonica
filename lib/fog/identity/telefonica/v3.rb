require 'fog/identity/telefonica'

module Fog
  module Identity
    class Telefonica
      class V3 < Fog::Service
        requires :telefonica_auth_url
        recognizes :telefonica_auth_token, :telefonica_management_url, :persistent,
                   :telefonica_service_type, :telefonica_service_name, :telefonica_tenant,
                   :telefonica_endpoint_type, :telefonica_region, :telefonica_domain_id,
                   :telefonica_project_name, :telefonica_domain_name,
                   :telefonica_user_domain, :telefonica_project_domain,
                   :telefonica_user_domain_id, :telefonica_project_domain_id,
                   :telefonica_api_key, :telefonica_current_user_id, :telefonica_userid, :telefonica_username,
                   :current_user, :current_user_id, :current_tenant,
                   :provider, :telefonica_identity_prefix, :telefonica_endpoint_path_matches, :telefonica_cache_ttl

        model_path 'fog/identity/telefonica/v3/models'
        model :domain
        collection :domains
        model :endpoint
        collection :endpoints
        model :project
        collection :projects
        model :service
        collection :services
        model :token
        collection :tokens
        model :user
        collection :users
        model :group
        collection :groups
        model :role
        collection :roles
        model :role_assignment
        collection :role_assignments
        model :os_credential
        collection :os_credentials
        model :policy
        collection :policies

        request_path 'fog/identity/telefonica/v3/requests'

        request :list_users
        request :get_user
        request :create_user
        request :update_user
        request :delete_user
        request :list_user_groups
        request :list_user_projects
        request :list_groups
        request :get_group
        request :create_group
        request :update_group
        request :delete_group
        request :add_user_to_group
        request :remove_user_from_group
        request :group_user_check
        request :list_group_users
        request :list_roles
        request :list_role_assignments
        request :get_role
        request :create_role
        request :update_role
        request :delete_role
        request :auth_domains
        request :auth_projects
        request :list_domains
        request :get_domain
        request :create_domain
        request :update_domain
        request :delete_domain
        request :list_domain_user_roles
        request :grant_domain_user_role
        request :check_domain_user_role
        request :revoke_domain_user_role
        request :list_domain_group_roles
        request :grant_domain_group_role
        request :check_domain_group_role
        request :revoke_domain_group_role
        request :list_endpoints
        request :get_endpoint
        request :create_endpoint
        request :update_endpoint
        request :delete_endpoint
        request :list_projects
        request :get_project
        request :create_project
        request :update_project
        request :delete_project
        request :list_project_user_roles
        request :grant_project_user_role
        request :check_project_user_role
        request :revoke_project_user_role
        request :list_project_group_roles
        request :grant_project_group_role
        request :check_project_group_role
        request :revoke_project_group_role
        request :list_services
        request :get_service
        request :create_service
        request :update_service
        request :delete_service
        request :token_authenticate
        request :token_validate
        request :token_check
        request :token_revoke
        request :list_os_credentials
        request :get_os_credential
        request :create_os_credential
        request :update_os_credential
        request :delete_os_credential
        request :list_policies
        request :get_policy
        request :create_policy
        request :update_policy
        request :delete_policy

        class Mock
          include Fog::Telefonica::Core
          def initialize(options = {})
          end
        end

        def self.get_api_version(uri, connection_options = {})
          connection = Fog::Core::Connection.new(uri, false, connection_options)
          response = connection.request(:expects => [200],
                                        :headers => {'Content-Type' => 'application/json',
                                                     'Accept'       => 'application/json'},
                                        :method  => 'GET')

          body = Fog::JSON.decode(response.body)
          version = nil
          unless body['version'].empty?
            version = body['version']['id']
          end
          if version.nil?
            raise Fog::Telefonica::Errors::ServiceUnavailable, "No version available at #{uri}"
          end

          version
        end

        class Real < Fog::Identity::Telefonica::Real
          private

          def default_service_type(_)
            DEFAULT_SERVICE_TYPE_V3
          end

          def initialize_endpoint_path_matches(options)
            if options[:telefonica_endpoint_path_matches]
              @telefonica_endpoint_path_matches = options[:telefonica_endpoint_path_matches]
            else
              @telefonica_endpoint_path_matches = %r{/v3} unless options[:telefonica_identity_prefix]
            end
          end
        end
      end
    end
  end
end
