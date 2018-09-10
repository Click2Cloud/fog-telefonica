
module Fog
  module Monitoring
    class Telefonica < Fog::Service
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

      model_path 'fog/monitoring/telefonica/models'
      model       :metric
      collection  :metrics
      model       :measurement
      collection  :measurements
      model       :statistic
      collection  :statistics
      model       :notification_method
      collection  :notification_methods
      model       :alarm_definition
      collection  :alarm_definitions
      model       :alarm
      collection  :alarms
      model       :alarm_state
      collection  :alarm_states
      model       :alarm_count
      collection  :alarm_counts
      model       :dimension_value

      request_path 'fog/monitoring/telefonica/requests'
      request :create_metric
      request :create_metric_array
      request :list_metrics
      request :list_metric_names

      request :find_measurements

      request :list_statistics

      request :create_notification_method
      request :get_notification_method
      request :list_notification_methods
      request :put_notification_method
      request :patch_notification_method
      request :delete_notification_method

      request :create_alarm_definition
      request :list_alarm_definitions
      request :patch_alarm_definition
      request :update_alarm_definition
      request :get_alarm_definition
      request :delete_alarm_definition

      request :list_alarms
      request :get_alarm
      request :patch_alarm
      request :update_alarm
      request :delete_alarm
      request :get_alarm_counts

      request :list_alarm_state_history_for_specific_alarm
      request :list_alarm_state_history_for_all_alarms

      request :list_dimension_values

      request :list_notification_method_types

      class Real
        include Fog::Telefonica::Core

        def self.not_found_class
          Fog::Monitoring::Telefonica::NotFound
        end

        def initialize(options = {})
          initialize_identity options

          @telefonica_service_type           = options[:telefonica_service_type] || ['monitoring']
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
