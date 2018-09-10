require 'fog/telefonica/models/model'

module Fog
  module Metric
    class Telefonica
      class Metric < Fog::Telefonica::Model
        identity :id

        attribute :name
        attribute :resource_id
        attribute :unit
        attribute :created_by_project_id
        attribute :created_by_user_id
        attribute :definition
      end
    end
  end
end
