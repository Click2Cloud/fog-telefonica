require 'fog/identity/telefonica'

module Fog
  module Identity
    class Telefonica
      class V2 < Fog::Service
        requires :telefonica_auth_url
        recognizes :telefonica_auth_token, :telefonica_management_url,
                   :persistent, :telefonica_service_type, :telefonica_service_name,
                   :telefonica_tenant, :telefonica_tenant_id,
                   :telefonica_api_key, :telefonica_username, :telefonica_identity_endpoint,
                   :current_user, :current_tenant, :telefonica_region,
                   :telefonica_endpoint_type, :telefonica_cache_ttl,
                   :telefonica_project_name, :telefonica_project_id,
                   :telefonica_project_domain, :telefonica_user_domain, :telefonica_domain_name,
                   :telefonica_project_domain_id, :telefonica_user_domain_id, :telefonica_domain_id,
                   :telefonica_identity_prefix, :telefonica_endpoint_path_matches

        model_path 'fog/identity/telefonica/v2/models'
        model :tenant
        collection :tenants
        model :user
        collection :users
        model :role
        collection :roles
        model :ec2_credential
        collection :ec2_credentials

        request_path 'fog/identity/telefonica/v2/requests'

        request :check_token
        request :validate_token

        request :list_tenants
        request :create_tenant
        request :get_tenant
        request :get_tenants_by_id
        request :get_tenants_by_name
        request :update_tenant
        request :delete_tenant

        request :list_users
        request :create_user
        request :update_user
        request :delete_user
        request :get_user_by_id
        request :get_user_by_name
        request :add_user_to_tenant
        request :remove_user_from_tenant

        request :list_endpoints_for_token
        request :list_roles_for_user_on_tenant
        request :list_user_global_roles

        request :create_role
        request :delete_role
        request :delete_user_role
        request :create_user_role
        request :get_role
        request :list_roles

        request :set_tenant

        request :create_ec2_credential
        request :delete_ec2_credential
        request :get_ec2_credential
        request :list_ec2_credentials

        class Mock
          attr_reader :auth_token
          attr_reader :auth_token_expiration
          attr_reader :current_user
          attr_reader :current_tenant
          attr_reader :unscoped_token

          def self.data
            @users ||= {}
            @roles ||= {}
            @tenants ||= {}
            @ec2_credentials ||= Hash.new { |hash, key| hash[key] = {} }
            @user_tenant_membership ||= {}

            @data ||= Hash.new do |hash, key|
              hash[key] = {
                :users                  => @users,
                :roles                  => @roles,
                :tenants                => @tenants,
                :ec2_credentials        => @ec2_credentials,
                :user_tenant_membership => @user_tenant_membership
              }
            end
          end

          def self.reset!
            @data = nil
            @users = nil
            @roles = nil
            @tenants = nil
            @ec2_credentials = nil
          end

          def initialize(options = {})
            @telefonica_username = options[:telefonica_username] || 'admin'
            @telefonica_tenant = options[:telefonica_tenant] || 'admin'
            @telefonica_auth_uri = URI.parse(options[:telefonica_auth_url])
            @telefonica_management_url = @telefonica_auth_uri.to_s

            @auth_token = Fog::Mock.random_base64(64)
            @auth_token_expiration = (Time.now.utc + 86400).iso8601

            @admin_tenant = data[:tenants].values.find do |u|
              u['name'] == 'admin'
            end

            if @telefonica_tenant
              @current_tenant = data[:tenants].values.find do |u|
                u['name'] == @telefonica_tenant
              end

              if @current_tenant
                @current_tenant_id = @current_tenant['id']
              else
                @current_tenant_id = Fog::Mock.random_hex(32)
                @current_tenant = data[:tenants][@current_tenant_id] = {
                  'id'   => @current_tenant_id,
                  'name' => @telefonica_tenant
                }
              end
            else
              @current_tenant = @admin_tenant
            end

            @current_user = data[:users].values.find do |u|
              u['name'] == @telefonica_username
            end
            @current_tenant_id = Fog::Mock.random_hex(32)

            if @current_user
              @current_user_id = @current_user['id']
            else
              @current_user_id = Fog::Mock.random_hex(32)
              @current_user = data[:users][@current_user_id] = {
                'id'       => @current_user_id,
                'name'     => @telefonica_username,
                'email'    => "#{@telefonica_username}@mock.com",
                'tenantId' => Fog::Mock.random_numbers(6).to_s,
                'enabled'  => true
              }
            end
          end

          def data
            self.class.data[@telefonica_username]
          end

          def reset_data
            self.class.data.delete(@telefonica_username)
          end

          def credentials
            {:provider                  => 'telefonica',
             :telefonica_auth_url        => @telefonica_auth_uri.to_s,
             :telefonica_auth_token      => @auth_token,
             :telefonica_management_url  => @telefonica_management_url,
             :telefonica_current_user_id => @telefonica_current_user_id,
             :current_user              => @current_user,
             :current_tenant            => @current_tenant}
          end
        end

        class Real < Fog::Identity::Telefonica::Real
          private

          def default_service_type(_)
            DEFAULT_SERVICE_TYPE
          end
        end
      end
    end
  end
end
