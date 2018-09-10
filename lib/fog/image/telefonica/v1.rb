require 'fog/image/telefonica'

module Fog
  module Image
    class Telefonica
      class V1 < Fog::Service
        SUPPORTED_VERSIONS = /v1(\.(0|1))*/

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

        model_path 'fog/image/telefonica/v1/models'

        model       :image
        collection  :images

        request_path 'fog/image/telefonica/v1/requests'

        request :list_public_images
        request :list_public_images_detailed
        request :get_image
        request :create_image
        request :update_image
        request :get_image_members
        request :update_image_members
        request :get_shared_images
        request :add_member_to_image
        request :remove_member_from_image
        request :delete_image
        request :get_image_by_id
        request :set_tenant

        class Mock
          def self.data
            @data ||= Hash.new do |hash, key|
              hash[key] = {
                :images => {}
              }
            end
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

          def self.not_found_class
            Fog::Image::Telefonica::NotFound
          end

          def initialize(options = {})
            initialize_identity options

            @telefonica_service_type           = options[:telefonica_service_type] || ['image']
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
              @path = Fog::Telefonica.get_supported_version_path(SUPPORTED_VERSIONS,
                                                                @telefonica_management_uri,
                                                                @auth_token,
                                                                @connection_options)
            end
          end
        end
      end
    end
  end
end
