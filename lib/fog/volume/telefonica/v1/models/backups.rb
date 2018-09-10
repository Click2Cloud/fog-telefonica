require 'fog/telefonica/models/collection'
require 'fog/volume/telefonica/v1/models/backup'
require 'fog/volume/telefonica/models/backups'

module Fog
  module Volume
    class Telefonica
      class V1
        class Backups < Fog::Telefonica::Collection
          model Fog::Volume::Telefonica::V1::Backup
          include Fog::Volume::Telefonica::Backups
        end
      end
    end
  end
end
