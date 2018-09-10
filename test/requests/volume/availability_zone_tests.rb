require 'test_helper'

describe "Fog::Volume[:telefonica] | availability zone requests" do
  before do
    @flavor_format = {
      'zoneName'  => String,
      'zoneState' => Hash
    }
  end

  describe "success" do
    it "#list_zones" do
      Fog::Volume[:telefonica].list_zones.body.
        must_match_schema('availabilityZoneInfo' => [@flavor_format])
    end
  end
end
