require 'fog/telefonica/models/model'

module Fog
  module Introspection
    class Telefonica
      class Rules < Fog::Telefonica::Model
        identity :uuid

        attribute :description
        attribute :actions
        attribute :conditions
        attribute :links

        def create
          requires :actions, :conditions
          attributes[:description] = description || ""
          merge_attributes(service.create_rules(attributes).body)
          self
        end

        def destroy
          requires :uuid
          service.delete_rules(uuid)
          true
        end
      end
    end
  end
end
