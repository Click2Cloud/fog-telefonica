require 'fog/telefonica'

# Add additional port to an Telefonica node

def create_virtual_address_pairing(username, password, auth_url, tenant, device_id, device_ip_address, network_id)
  network_driver = Fog::Network.new(:provider           => :telefonica,
                                    :telefonica_api_key  => password,
                                    :telefonica_username => username,
                                    :telefonica_auth_url => auth_url,
                                    :telefonica_tenant   => tenant)

  virtual_ip_address = network_driver.create_port(network_id)

  server_nics = network_driver.list_ports('device_id' => device_id).data[:body]['ports']
  port = (server_nics.select do |network_port|
    network_port['mac_address'] == server.attributes['macaddress']
  end).first

  network_driver.update_port(port['id'], :allowed_address_pairs => [{:ip_address => device_ip_address},
                                                                    {:ip_address => virtual_ip_address}])
end
