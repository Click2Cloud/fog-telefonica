require 'fog/volume/telefonica/models/backup'

module Fog
  module Volume
    class Telefonica
      class V2
        class Backup < Fog::Volume::Telefonica::Backup
          identity :id

          superclass.attributes.each { |attrib| attribute attrib }
        end
      end
    end
  end
end
