require 'fog/telefonica'
require 'time'

auth_url = "http://10.0.0.101:5000/v2.0/tokens"
username = 'admin'
password = 'D78JVyRnzJG8j7Mb6fgpeUMp7'

@connection_params = {
    :telefonica_auth_url     => auth_url,
    :telefonica_username     => username,
    :telefonica_api_key      => password,
}

puts "### SERVICE CONNECTION ###"

event_service = Fog::Event::Telefonica.new(@connection_params)

p event_service

puts "### LIST EVENTS ###"

p event_service.events.all
