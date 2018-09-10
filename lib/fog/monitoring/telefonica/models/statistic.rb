require 'fog/telefonica/models/model'

module Fog
  module Monitoring
    class Telefonica
      class Statistic < Fog::Telefonica::Model
        identity :id

        attribute :name
        attribute :dimension
        attribute :columns
        attribute :statistics

        def to_s
          name
        end
      end
    end
  end
end
