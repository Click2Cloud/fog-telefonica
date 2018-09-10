require 'fog/telefonica/models/model'

module Fog
  module Monitoring
    class Telefonica
      class AlarmCount < Fog::Telefonica::Model
        attribute :links
        attribute :columns
        attribute :counts

        def to_s
          name
        end
      end
    end
  end
end
