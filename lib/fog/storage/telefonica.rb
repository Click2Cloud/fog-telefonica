

module Fog
  module Storage
    class Telefonica < Fog::Service
      requires   :telefonica_auth_url
      recognizes :telefonica_auth_token, :telefonica_management_url,
                 :persistent, :telefonica_service_type, :telefonica_service_name,
                 :telefonica_tenant, :telefonica_tenant_id, :telefonica_userid,
                 :telefonica_api_key, :telefonica_username, :telefonica_identity_endpoint,
                 :current_user, :current_tenant, :telefonica_region,
                 :telefonica_endpoint_type, :telefonica_auth_omit_default_port,
                 :telefonica_project_name, :telefonica_project_id, :telefonica_cache_ttl,
                 :telefonica_project_domain, :telefonica_user_domain, :telefonica_domain_name,
                 :telefonica_project_domain_id, :telefonica_user_domain_id, :telefonica_domain_id,
                 :telefonica_identity_prefix, :telefonica_temp_url_key

      model_path 'fog/storage/telefonica/models'
      model       :directory
      collection  :directories
      model       :file
      collection  :files

      request_path 'fog/storage/telefonica/requests'
      request :copy_object
      request :delete_container
      request :delete_object
      request :delete_multiple_objects
      request :delete_static_large_object
      request :get_container
      request :get_containers
      request :get_object
      request :get_object_http_url
      request :get_object_https_url
      request :head_container
      request :head_containers
      request :head_object
      request :put_container
      request :put_object
      request :post_object
      request :put_object_manifest
      request :put_dynamic_obj_manifest
      request :put_static_obj_manifest
      request :post_set_meta_temp_url_key
      request :public_url

      module Utils
        def require_mime_types
          # Use mime/types/columnar if available, for reduced memory usage
          require 'mime/types/columnar'
          rescue LoadError
            begin
              require 'mime/types'
            rescue LoadError
              Fog::Logger.warning("'mime-types' missing, please install and try again.")
              exit(1)
            end
          end
      end

      class Mock
        include Utils
        def self.data
          @data ||= Hash.new do |hash, key|
            hash[key] = {}
          end
        end

        def self.reset
          @data = nil
        end

        def initialize(options = {})
          require_mime_types
          @telefonica_api_key = options[:telefonica_api_key]
          @telefonica_username = options[:telefonica_username]
          @telefonica_management_url = options[:telefonica_management_url] || 'http://example:8774/v2/AUTH_1234'

          @telefonica_management_uri = URI.parse(@telefonica_management_url)

          @host   = @telefonica_management_uri.host
          @path   = @telefonica_management_uri.path
          @path.sub!(%r{/$}, '')
          @port   = @telefonica_management_uri.port
          @scheme = @telefonica_management_uri.scheme
        end

        def data
          self.class.data[@telefonica_username]
        end

        def reset_data
          self.class.data.delete(@telefonica_username)
        end

        def change_account(account)
          @original_path ||= @path
          version_string = @original_path.split('/')[1]
          @path = "/#{version_string}/#{account}"
        end

        def reset_account_name
          @path = @original_path
        end
      end

      class Real
        include Utils
        include Fog::Telefonica::Core

        def self.not_found_class
          Fog::Storage::Telefonica::NotFound
        end

        def initialize(options = {})
          require_mime_types
          initialize_identity options

          @telefonica_service_type           = options[:telefonica_service_type] || ['object-store']
          @telefonica_service_name           = options[:telefonica_service_name]

          @connection_options               = options[:connection_options] || {}

          authenticate
          @persistent = options[:persistent] || false
          @connection = Fog::Core::Connection.new("#{@scheme}://#{@host}:#{@port}", @persistent, @connection_options)
        end

        # Change the current account while re-using the auth token.
        #
        # This is usefull when you have an admin role and you're able
        # to HEAD other user accounts, set quotas, list files, etc.
        #
        # For example:
        #
        #     # List current user account details
        #     service = Fog::Storage[:telefonica]
        #     service.request :method => 'HEAD'
        #
        # Would return something like:
        #
        #     Account:                      AUTH_1234
        #     Date:                         Tue, 05 Mar 2013 16:50:52 GMT
        #     X-Account-Bytes-Used:         0 (0.00 Bytes)
        #     X-Account-Container-Count:    0
        #     X-Account-Object-Count:       0
        #
        # Now let's change the account
        #
        #     service.change_account('AUTH_3333')
        #     service.request :method => 'HEAD'
        #
        # Would return something like:
        #
        #     Account:                      AUTH_3333
        #     Date:                         Tue, 05 Mar 2013 16:51:53 GMT
        #     X-Account-Bytes-Used:         23423433
        #     X-Account-Container-Count:    2
        #     X-Account-Object-Count:       10
        #
        # If we wan't to go back to our original admin account:
        #
        #     service.reset_account_name
        #
        def change_account(account)
          @original_path ||= @path
          version_string = @path.split('/')[1]
          @path = "/#{version_string}/#{account}"
        end

        def reset_account_name
          @path = @original_path
        end
      end
    end
  end
end
