require 'fog/telefonica/models/model'

module Fog
  module Identity
    class Telefonica
      class V3
        class RoleAssignment < Fog::Telefonica::Model
          attribute :scope
          attribute :role
          attribute :user
          attribute :group
          attribute :links

          def to_s
            links['assignment']
          end
        end
      end
    end
  end
end
