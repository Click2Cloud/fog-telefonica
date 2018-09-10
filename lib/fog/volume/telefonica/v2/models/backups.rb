require 'fog/telefonica/models/collection'
require 'fog/volume/telefonica/v2/models/backup'
require 'fog/volume/telefonica/models/backups'

module Fog
  module Volume
    class Telefonica
      class V2
        class Backups < Fog::Telefonica::Collection
          model Fog::Volume::Telefonica::V2::Backup
          include Fog::Volume::Telefonica::Backups
        end
      end
    end
  end
end
