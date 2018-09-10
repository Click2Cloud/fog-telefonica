require 'test_helper'

require 'fog/volume/telefonica'
require 'fog/volume/telefonica/v1'
require 'fog/volume/telefonica/v2'

describe "Fog::Volume[:telefonica], ['telefonica', 'volume']" do
  volume = Fog::Volume[:telefonica]

  describe "Volumes collection" do
    %w{ volumes }.each do |collection|
      it "should respond to #{collection}" do
        volume.respond_to? collection
      end

      it "should respond to #{collection}.all" do
        eval("volume.#{collection}").respond_to? 'all'
      end

      # not implemented
      # it "should respond to #{collection}.get" do
      #   eval("volume.#{collection}").respond_to? 'get'
      # end
    end
  end
end
