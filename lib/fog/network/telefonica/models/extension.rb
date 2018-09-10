require 'fog/telefonica/models/model'

module Fog
  module Network
    class Telefonica
      class Extension < Fog::Telefonica::Model
        identity :id
        attribute :name
        attribute :links
        attribute :description
        attribute :alias
      end
    end
  end
end
