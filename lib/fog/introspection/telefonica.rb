require 'yaml'

module Fog
  module Introspection
    class Telefonica < Fog::Service
      SUPPORTED_VERSIONS = /v1/

      requires :telefonica_auth_url
      recognizes :telefonica_auth_token, :telefonica_management_url,
                 :persistent, :telefonica_service_type, :telefonica_service_name,
                 :telefonica_tenant, :telefonica_tenant_id,
                 :telefonica_api_key, :telefonica_username, :telefonica_identity_endpoint,
                 :current_user, :current_tenant, :telefonica_region,
                 :telefonica_endpoint_type, :telefonica_cache_ttl,
                 :telefonica_project_name, :telefonica_project_id,
                 :telefonica_project_domain, :telefonica_user_domain, :telefonica_domain_name,
                 :telefonica_project_domain_id, :telefonica_user_domain_id, :telefonica_domain_id

      ## REQUESTS
      #
      request_path 'fog/introspection/telefonica/requests'

      # Introspection requests
      request :create_introspection
      request :get_introspection
      request :abort_introspection
      request :get_introspection_details

      # Rules requests
      request :create_rules
      request :list_rules
      request :delete_rules_all
      request :get_rules
      request :delete_rules

      ## MODELS
      #
      model_path 'fog/introspection/telefonica/models'
      model       :rules
      collection  :rules_collection

      class Mock
        def self.data
          @data ||= Hash.new do |hash, key|
            # Introspection data is *huge* we load it from a yaml file
            file = "../../../../test/fixtures/introspection.yaml"
            hash[key] = YAML.load(File.read(File.expand_path(file, __FILE__)))
          end
        end

        def self.reset
          @data = nil
        end

        include Fog::Telefonica::Core

        def initialize(options = {})
          @auth_token = Fog::Mock.random_base64(64)
          @auth_token_expiration = (Time.now.utc + 86_400).iso8601

          initialize_identity options
        end

        def data
          self.class.data[@telefonica_username]
        end

        def reset_data
          self.class.data.delete(@telefonica_username)
        end
      end

      class Real
        include Fog::Telefonica::Core

        def self.not_found_class
          Fog::Introspection::Telefonica::NotFound
        end

        def initialize(options = {})
          initialize_identity options

          @telefonica_service_type  = options[:telefonica_service_type] || ['baremetal-introspection']
          @telefonica_service_name  = options[:telefonica_service_name]

          @connection_options = options[:connection_options] || {}

          authenticate
          set_api_path

          @persistent = options[:persistent] || false
          @connection = Fog::Core::Connection.new("#{@scheme}://#{@host}:#{@port}", @persistent, @connection_options)
        end

        def set_api_path
          unless @path.match(SUPPORTED_VERSIONS)
            @path = "/v1"
          end
        end
      end
    end
  end
end
