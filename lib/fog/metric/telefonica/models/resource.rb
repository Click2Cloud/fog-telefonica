require 'fog/telefonica/models/model'

module Fog
  module Metric
    class Telefonica
      class Resource < Fog::Telefonica::Model
        identity :id

        attribute :original_resource_id
        attribute :project_id
        attribute :user_id
        attribute :metrics
      end
    end
  end
end
