require 'fog/telefonica/models/model'

module Fog
  module Metering
    class Telefonica
      class Resource < Fog::Telefonica::Model
        identity :resource_id

        attribute :project_id
        attribute :user_id
        attribute :metadata
      end
    end
  end
end
