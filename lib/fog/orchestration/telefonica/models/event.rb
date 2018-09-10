require 'fog/telefonica/models/model'

module Fog
  module Orchestration
    class Telefonica
      class Event < Fog::Telefonica::Model
        include Reflectable

        identity :id

        %w(resource_name event_time links logical_resource_id resource_status
           resource_status_reason physical_resource_id).each do |a|
          attribute a.to_sym
        end
      end
    end
  end
end
