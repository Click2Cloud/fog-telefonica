require 'fog/telefonica/models/model'

module Fog
  module SharedFileSystem
    class Telefonica
      class ShareExportLocation < Fog::Telefonica::Model
        identity :id
        
        attribute :share_instance_id
        attribute :path
        attribute :is_admin_only
        attribute :preferred
      end
    end
  end
end
