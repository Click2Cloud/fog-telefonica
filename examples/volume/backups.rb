require 'fog/telefonica'
require 'fog/workflow/telefonica/v2'

auth_url = "http://192.0.2.1:5000/v3/auth/tokens"
username = "admin"
password = "1b1d81f7e25b53e497246b168971823c5754f395"
project  = "admin"

@connection_params = {
  :telefonica_auth_url     => auth_url,
  :telefonica_username     => username,
  :telefonica_api_key      => password,
  :telefonica_project_name => project,
  :telefonica_domain_id    => "default",
}

cinder = Fog::Volume::Telefonica.new(@connection_params)

puts "INFO: create backup of existing volume named test"

response = cinder.create_backup({:name => 'test-backup',
                                 :volume_id => '82fe2ad5-43a3-4c2b-8464-e57b138ea81c'})
puts response.body

puts "INFO: list backups"

backups = cinder.backups

puts "INFO: get details of existing backup"

backup_id = backups[0].id
backup = cinder.backups.get(backup_id)

puts "INFO: restore backup"

response = backup.restore('82fe2ad5-43a3-4c2b-8464-e57b138ea81c')
puts response.body

puts "INFO: delete backup"

backup.destroy
