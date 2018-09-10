# Use so you can run in mock mode from the command line
#
# FOG_MOCK=true fog

if ENV["FOG_MOCK"] == "true"
  Fog.mock!
end

# if in mocked mode, fill in some fake credentials for us
if Fog.mock?
  Fog.credentials = {
    :telefonica_api_key  => 'telefonica_api_key',
    :telefonica_username => 'telefonica_username',
    :telefonica_tenant   => 'telefonica_tenant',
    :telefonica_auth_url => 'http://telefonica:35357/v2.0/tokens',
  }.merge(Fog.credentials)
end
