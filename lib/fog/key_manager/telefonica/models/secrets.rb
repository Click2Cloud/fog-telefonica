require 'fog/telefonica/models/collection'
require 'fog/key_manager/telefonica/models/secret'

module Fog
  module KeyManager
    class Telefonica
      class Secrets < Fog::Telefonica::Collection
        model Fog::KeyManager::Telefonica::Secret

        def all(options = {})
          load_response(service.list_secrets(options), 'secrets')
        end

        def get(secret_ref)
          if secret = service.get_secret(secret_ref).body
            new(secret)
          end
        rescue Fog::Compute::Telefonica::NotFound
          nil
        end

      end
    end
  end
end