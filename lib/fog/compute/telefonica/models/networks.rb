require 'fog/telefonica/models/collection'
require 'fog/compute/telefonica/models/network'

module Fog
  module Compute
    class Telefonica
      class Networks < Fog::Telefonica::Collection
        model Fog::Compute::Telefonica::Network

        attribute :server

        def all
          requires :server

          networks = []
          server.addresses.each_with_index do |address, index|
            networks << {
              :id        => index + 1,
              :name      => address[0],
              :addresses => address[1].map { |a| a['addr'] }
            }
          end

          # TODO: convert to load_response?
          load(networks)
        end
      end
    end
  end
end
