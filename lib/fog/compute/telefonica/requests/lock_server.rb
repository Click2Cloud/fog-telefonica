module Fog
  module Compute
    class Telefonica
      class Real
        def lock_server(server_id)
          body = { 'lock' => nil }
          server_action(server_id, body).status == 202
        end # def lock_servers
      end # class Real

      class Mock
        def lock_server(_server_id)
          true
        end # def lock_server
      end # class Mock
    end # class Telefonica
  end # module Compute
end # module Sdk
