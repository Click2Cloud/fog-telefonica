module Fog
  module Compute
    class Telefonica
      class Real
        def unlock_server(server_id)
          body = { 'unlock' => nil }
          server_action(server_id, body).status == 202
        end # def unlock_servers
      end # class Real

      class Mock
        def unlock_server(_server_id)
          true
        end # def unlock__server
      end # class Mock
    end # class Telefonica
  end # module Compute
end # module Sdk
