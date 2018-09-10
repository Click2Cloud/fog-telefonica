
require 'fog/telefonica/models/model'

module Fog
  module KeyManager
    class Telefonica

      class ACL < Fog::Telefonica::Model
        identity :acl_ref

        attribute :uuid
        attribute :operation_type
        attribute :users, type: Array
        attribute :project_access
        attribute :secret_type
        attribute :created
        attribute :creator_id
        attribute :updated

      end
    end
  end
end
