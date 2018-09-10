require 'fog/telefonica/models/model'

module Fog
  module Monitoring
    class Telefonica
      class Measurement < Fog::Telefonica::Model
        identity :id

        attribute :name
        attribute :dimensions
        attribute :columns
        attribute :measurements

        def to_s
          name
        end
      end
    end
  end
end
