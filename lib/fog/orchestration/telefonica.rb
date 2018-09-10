

module Fog
  module Orchestration
    class Telefonica < Fog::Service
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
                 :telefonica_identity_prefix

      model_path 'fog/orchestration/telefonica/models'
      model       :stack
      collection  :stacks

      model :resource
      collection :resources

      collection :resource_schemas

      model :event
      collection :events

      model :template
      collection :templates

      request_path 'fog/orchestration/telefonica/requests'
      request :abandon_stack
      request :build_info
      request :create_stack
      request :delete_stack
      request :get_stack_template
      request :list_events
      request :list_resource_events
      request :list_resource_types
      request :list_resources
      request :list_stack_data
      request :list_stack_data_detailed
      request :list_stack_events
      request :preview_stack
      request :show_event_details
      request :show_resource_data
      request :show_resource_metadata
      request :show_resource_schema
      request :show_resource_template
      request :show_stack_details
      request :update_stack
      request :patch_stack
      request :validate_template
      request :cancel_update

      module Reflectable
        REFLECTION_REGEX = /\/stacks\/(\w+)\/([\w|-]+)\/resources\/(\w+)/

        def resource
          @resource ||= service.resources.get(r[3], stack)
        end

        def stack
          @stack ||= service.stacks.get(r[1], r[2])
        end

        private

        def reflection
          @reflection ||= REFLECTION_REGEX.match(links[0]['href'])
        end
        alias r reflection
      end

      class Mock
        attr_reader :auth_token
        attr_reader :auth_token_expiration
        attr_reader :current_user
        attr_reader :current_tenant

        def self.data
          @data ||= Hash.new do |hash, key|
            hash[key] = {
              :stacks => {}
            }
          end
        end

        def self.reset
          @data = nil
        end

        def initialize(options = {})
          @telefonica_username = options[:telefonica_username]
          @telefonica_auth_uri = URI.parse(options[:telefonica_auth_url])

          @current_tenant = options[:telefonica_tenant]

          @auth_token = Fog::Mock.random_base64(64)
          @auth_token_expiration = (Time.now.utc + 86400).iso8601

          management_url = URI.parse(options[:telefonica_auth_url])
          management_url.port = 8774
          management_url.path = '/v1'
          @telefonica_management_url = management_url.to_s

          identity_public_endpoint = URI.parse(options[:telefonica_auth_url])
          identity_public_endpoint.port = 5000
          @telefonica_identity_public_endpoint = identity_public_endpoint.to_s
        end

        def data
          self.class.data["#{@telefonica_username}-#{@current_tenant}"]
        end

        def reset_data
          self.class.data.delete("#{@telefonica_username}-#{@current_tenant}")
        end

        def credentials
          {:provider                    => 'telefonica',
           :telefonica_auth_url          => @telefonica_auth_uri.to_s,
           :telefonica_auth_token        => @auth_token,
           :telefonica_management_url    => @telefonica_management_url,
           :telefonica_identity_endpoint => @telefonica_identity_public_endpoint}
        end
      end

      class Real
        include Fog::Telefonica::Core

        def self.not_found_class
          Fog::Orchestration::Telefonica::NotFound
        end

        def initialize(options = {})
          initialize_identity options

          @telefonica_identity_service_type = options[:telefonica_identity_service_type] || 'identity'

          @telefonica_service_type           = options[:telefonica_service_type] || ['orchestration']
          @telefonica_service_name           = options[:telefonica_service_name]

          @connection_options               = options[:connection_options] || {}

          authenticate

          @persistent = options[:persistent] || false
          @connection = Fog::Core::Connection.new("#{@scheme}://#{@host}:#{@port}", @persistent, @connection_options)
        end
      end
    end
  end
end
