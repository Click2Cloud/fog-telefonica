require 'fog/dns/telefonica'

module Fog
  module DNS
    class Telefonica
      class V1 < Fog::Service
        requires   :telefonica_auth_url
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

        request_path 'fog/dns/telefonica/v1/requests'

        request :list_domains

        request :get_quota
        request :update_quota

        class Mock
          def self.data
            @data ||= Hash.new do |hash, key|
              hash[key] = {
                :domains => [{
                  "id"          => "a86dba58-0043-4cc6-a1bb-69d5e86f3ca3",
                  "name"        => "example.org.",
                  "email"       => "joe@example.org",
                  "ttl"         => 7200,
                  "serial"      => 1_404_757_531,
                  "description" => "This is an example zone.",
                  "created_at"  => "2014-07-07T18:25:31.275934",
                  "updated_at"  => ''
                }],
                :quota   => {
                  "api_export_size"   => 1000,
                  "recordset_records" => 20,
                  "domain_records"    => 500,
                  "domain_recordsets" => 500,
                  "domains"           => 100
                }
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
            management_url.port = 9001
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
            Fog::DNS::Telefonica::NotFound
          end

          def initialize(options = {})
            initialize_identity options

            @telefonica_service_type           = options[:telefonica_service_type] || ['dns']
            @telefonica_service_name           = options[:telefonica_service_name]

            @connection_options               = options[:connection_options] || {}

            authenticate
            set_api_path
            @persistent = options[:persistent] || false
            @connection = Fog::Core::Connection.new("#{@scheme}://#{@host}:#{@port}", @persistent, @connection_options)
          end

          def set_api_path
            # version explicitly set to allow usage also in 'DEPRECATED' mitaka version,
            # where f.i. quota modification was not possible at the time of creation
            @path = '/v1' unless @path =~ /v1/
          end
        end
      end
    end
  end
end
