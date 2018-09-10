require 'fog/telefonica/models/collection'
require 'fog/network/telefonica/models/extension'

module Fog
  module Network
    class Telefonica
      class Extensions < Fog::Telefonica::Collection
        attribute :filters

        model Fog::Network::Telefonica::Extension

        def initialize(attributes)
          self.filters ||= {}
          super
        end

        def all(filters_arg = filters)
          filters = filters_arg
          load_response(service.list_extensions(filters), 'extensions')
        end

        def get(extension_id)
          if extension = service.get_extension(extension_id).body['extension']
            new(extension)
          end
        rescue Fog::Network::Telefonica::NotFound
          nil
        end
      end
    end
  end
end
