require 'fog/telefonica/models/model'

module Fog
  module Event
    class Telefonica
      class Event < Fog::Telefonica::Model
        identity :message_id

        attribute :event_type
        attribute :generated
        attribute :raw
        attribute :traits
      end
    end
  end
end
