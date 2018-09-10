require 'fog/telefonica/models/collection'
require 'fog/identity/telefonica/v3/models/os_credential'

module Fog
  module Identity
    class Telefonica
      class V3
        class OsCredentials < Fog::Telefonica::Collection
          model Fog::Identity::Telefonica::V3::OsCredential

          def all(options = {})
            load_response(service.list_os_credentials(options), 'credentials')
          end

          def find_by_id(id)
            cached_credential = find { |credential| credential.id == id }
            return cached_credential if cached_credential
            credential_hash = service.get_os_credential(id).body['credential']
            Fog::Identity::Telefonica::V3::Credential.new(
              credential_hash.merge(:service => service)
            )
          end

          def destroy(id)
            credential = find_by_id(id)
            credential.destroy
          end
        end
      end
    end
  end
end
