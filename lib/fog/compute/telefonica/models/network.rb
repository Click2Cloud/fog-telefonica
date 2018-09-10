require 'fog/telefonica/models/model'

module Fog
  module Compute
    class Telefonica
      class Network < Fog::Telefonica::Model
        identity  :id
        attribute :name
        attribute :addresses
      end
    end
  end
end
