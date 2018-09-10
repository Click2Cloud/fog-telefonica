require 'fog/telefonica/models/model'

module Fog
  module Baremetal
    class Telefonica
      class Driver < Fog::Telefonica::Model
        identity :name

        attribute :name
        attribute :hosts

        def properties
          requires :name
          service.get_driver_properties(name).body
        end

        def metadata
          requires :name
          service.get_driver(name).headers
        end
      end
    end
  end
end
