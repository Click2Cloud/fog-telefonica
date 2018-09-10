module Fog
  module Storage
    class Telefonica
      module PublicUrl
        # Get public_url for an object
        #
        # ==== Parameters
        # * container<~String> - Name of container to look in
        # * object<~String> - Name of object to look for
        #
        def public_url(container = nil, object = nil)
          return nil if container.nil?
          u = "#{url}/#{Fog::Telefonica.escape(container)}"
          u << "/#{Fog::Telefonica.escape(object)}" unless object.nil?
          u
        end

        private

        def url
          "#{@scheme}://#{@host}:#{@port}#{@path}"
        end
      end

      class Real
        include PublicUrl
      end

      class Mock
        include PublicUrl
      end
    end
  end
end
