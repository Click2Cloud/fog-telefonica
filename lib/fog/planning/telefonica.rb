

module Fog
  module Telefonica
    class Planning < Fog::Service
      SUPPORTED_VERSIONS = /v2/

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

      ## MODELS
      #
      model_path 'fog/planning/telefonica/models'
      model       :role
      collection  :roles
      model       :plan
      collection  :plans

      ## REQUESTS
      #
      request_path 'fog/planning/telefonica/requests'

      # Role requests
      request :list_roles

      # Plan requests
      request :list_plans
      request :get_plan_templates
      request :get_plan
      request :patch_plan
      request :create_plan
      request :delete_plan
      request :add_role_to_plan
      request :remove_role_from_plan

      class Mock
        def self.data
          @data ||= {}
        end

        def self.reset
          @data = nil
        end

        def initialize(options = {})
          @telefonica_username = options[:telefonica_username]
          @telefonica_tenant   = options[:telefonica_tenant]
          @telefonica_auth_uri = URI.parse(options[:telefonica_auth_url])

          @auth_token = Fog::Mock.random_base64(64)
          @auth_token_expiration = (Time.now.utc + 86400).iso8601

          management_url = URI.parse(options[:telefonica_auth_url])
          management_url.port = 9292
          management_url.path = '/v1'
          @telefonica_management_url = management_url.to_s

          @data ||= {:users => {}}
          unless @data[:users].find { |u| u['name'] == options[:telefonica_username] }
            id = Fog::Mock.random_numbers(6).to_s
            @data[:users][id] = {
              'id'       => id,
              'name'     => options[:telefonica_username],
              'email'    => "#{options[:telefonica_username]}@mock.com",
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
          {:provider                 => 'telefonica',
           :telefonica_auth_url       => @telefonica_auth_uri.to_s,
           :telefonica_auth_token     => @auth_token,
           :telefonica_region         => @telefonica_region,
           :telefonica_management_url => @telefonica_management_url}
        end
      end

      class Real
        include Fog::Telefonica::Core

        # NOTE: uncommenting this should be treated as api-change!
        # def self.not_found_class
        #   Fog::Planning::Telefonica::NotFound
        # end

        def initialize(options = {})
          initialize_identity options

          @telefonica_service_type           = options[:telefonica_service_type] || ['management'] # currently Tuskar is configured as 'management' service in Keystone
          @telefonica_service_name           = options[:telefonica_service_name]
          @telefonica_endpoint_type          = options[:telefonica_endpoint_type] || 'adminURL'

          @connection_options               = options[:connection_options] || {}

          authenticate
          set_api_path

          @persistent = options[:persistent] || false
          @connection = Fog::Core::Connection.new("#{@scheme}://#{@host}:#{@port}", @persistent, @connection_options)
        end

        def set_api_path
          unless @path.match(SUPPORTED_VERSIONS)
            @path = "/v2"
          end
        end
      end
    end

    # TODO: get rid of inconform self.[] & self.new & self.services
    def self.[](service)
      new(:service => service)
    end

    def self.new(attributes)
      attributes = attributes.dup # Prevent delete from having side effects
      service = attributes.delete(:service).to_s.downcase.to_sym
      if services.include?(service)
        require "fog/#{service}/telefonica"
        return Fog::Telefonica.const_get(service.to_s.capitalize).new(attributes)
      end
      raise ArgumentError, "Telefonica has no #{service} service"
    end

    def self.services
      # Ruby 1.8.7 compatibility for select returning Array of Arrays (pairs)
      Hash[Fog.services.select { |_service, providers| providers.include?(:telefonica) }].keys
    end
  end
end
