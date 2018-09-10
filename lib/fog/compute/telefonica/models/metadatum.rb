require 'fog/telefonica/models/model'
require 'fog/telefonica/models/meta_parent'

module Fog
  module Compute
    class Telefonica
      class Metadatum < Fog::Telefonica::Model
        include Fog::Compute::Telefonica::MetaParent

        identity :key
        attribute :value

        def destroy
          requires :identity
          service.delete_meta(collection_name, @parent.id, key)
          true
        end

        def save
          requires :identity, :value
          service.update_meta(collection_name, @parent.id, key, value)
          true
        end
      end
    end
  end
end
