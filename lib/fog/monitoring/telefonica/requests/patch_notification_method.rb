module Fog
  module Monitoring
    class Telefonica
      class Real
        def update_notification_method(id, notification)
          request(
            :expects => [200],
            :method  => 'PATCH',
            :path    => "notification-methods/#{id}",
            :body    => Fog::JSON.encode(notification)
          )
        end
      end

      class Mock
      end
    end
  end
end
