require 'fog/telefonica/models/collection'
require 'fog/storage/telefonica/models/directory'

module Fog
  module Storage
    class Telefonica
      class Directories < Fog::Telefonica::Collection
        model Fog::Storage::Telefonica::Directory

        def all(options = {})
          data = service.get_containers(options)
          load_response(data)
        end

        def get(key, options = {})
          data = service.get_container(key, options)
          directory = new(:key => key)
          for key, value in data.headers
            if ['X-Container-Bytes-Used', 'X-Container-Object-Count'].include?(key)
              directory.merge_attributes(key => value)
            end
          end
          directory.files.merge_attributes(options)
          directory.files.instance_variable_set(:@loaded, true)

          data.body.each do |file|
            directory.files << directory.files.new(file)
          end
          directory
        rescue Fog::Storage::Telefonica::NotFound
          nil
        end
      end
    end
  end
end
