module Fog
  module KeyManager
    class Telefonica < Fog::Service
      SUPPORTED_VERSIONS = /v1(\.0)*/

      requires :telefonica_auth_url
      recognizes :telefonica_auth_token, :telefonica_management_url,
                 :persistent, :telefonica_service_type, :telefonica_service_name,
                 :telefonica_tenant, :telefonica_tenant_id, :telefonica_userid,
                 :telefonica_api_key, :telefonica_username, :telefonica_identity_endpoint,
                 :current_user, :current_tenant, :telefonica_region,
                 :telefonica_endpoint_type, :telefonica_auth_omit_default_port,
                 :telefonica_project_name, :telefonica_project_id,
                 :telefonica_project_domain, :telefonica_user_domain, :telefonica_domain_name,
                 :telefonica_project_domain_id, :telefonica_user_domain_id, :telefonica_domain_id,
                 :telefonica_identity_prefix, :telefonica_temp_url_key, :telefonica_cache_ttl


      ## MODELS
      #
      model_path 'fog/key_manager/telefonica/models'
      model       :secret
      collection  :secrets
      model       :container
      collection  :containers
      model       :acl

      ## REQUESTS

      # secrets
      request_path 'fog/key_manager/telefonica/requests'
      request :create_secret
      request :list_secrets
      request :get_secret
      request :get_secret_payload
      request :get_secret_metadata
      request :delete_secret

      # containers
      request :create_container
      request :get_container
      request :list_containers
      request :delete_container

      #ACL
      request :get_secret_acl
      request :update_secret_acl
      request :replace_secret_acl
      request :delete_secret_acl

      request :get_container_acl
      request :update_container_acl
      request :replace_container_acl
      request :delete_container_acl

      class Mock
        def initialize(options = {})
          @telefonica_username = options[:telefonica_username]
          @telefonica_tenant   = options[:telefonica_tenant]
          @telefonica_auth_uri = URI.parse(options[:telefonica_auth_url])

          @auth_token = Fog::Mock.random_base64(64)
          @auth_token_expiration = (Time.now.utc + 86400).iso8601

          management_url = URI.parse(options[:telefonica_auth_url])
          management_url.port = 9311
          management_url.path = '/v1'
          @telefonica_management_url = management_url.to_s

          @data ||= {:users => {}}
          unless @data[:users].detect { |u| u['name'] == options[:telefonica_username] }
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

        def self.not_found_class
          Fog::KeyManager::Telefonica::NotFound
        end

        def initialize(options = {})
          initialize_identity options

          @telefonica_service_type           = options[:telefonica_service_type] || ['key-manager']
          @telefonica_service_name           = options[:telefonica_service_name]
          @connection_options               = options[:connection_options] || {}

          authenticate
          set_api_path

          @persistent = options[:persistent] || false
          @connection = Fog::Core::Connection.new("#{@scheme}://#{@host}:#{@port}", @persistent, @connection_options)
        end

        def set_api_path
          @path.sub!(%r{/$}, '')
          unless @path.match(SUPPORTED_VERSIONS)
            @path = supported_version(SUPPORTED_VERSIONS, @telefonica_management_uri, @auth_token, @connection_options)
          end
        end

        def supported_version(supported_versions, uri, auth_token, connection_options = {})
          connection = Fog::Core::Connection.new("#{uri.scheme}://#{uri.host}:#{uri.port}", false, connection_options)
          response = connection.request({ :expects => [200, 204, 300],
                                          :headers => {'Content-Type' => 'application/json',
                                                       'Accept' => 'application/json',
                                                       'X-Auth-Token' => auth_token},
                                          :method => 'GET'
                                        })

          body = Fog::JSON.decode(response.body)
          version = nil

          versions =  body.fetch('versions',{}).fetch('values',[])
          versions.each do |v|
            if v.fetch('id', "").match(supported_versions) &&
              ['current', 'supported', 'stable'].include?(v.fetch('status','').downcase)
              version = v['id']
            end
          end

          if !version  || version.empty?
            raise Fog::Telefonica::Errors::ServiceUnavailable.new(
                    "Telefonica service only supports API versions #{supported_versions.inspect}")
          end

          version
        end

      end
    end
  end
end
