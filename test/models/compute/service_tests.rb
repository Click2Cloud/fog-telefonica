require "test_helper"

describe "Fog::Compute[:telefonica] | services" do
  describe "success" do
    before do
      services = Fog::Compute[:telefonica].services.all
      @service = services.first
    end

    it "#all" do
      @service.state.must_equal "up"
    end

    it "#get" do
      service = Fog::Compute[:telefonica].services.get(@service.id)
      %w(id binary host).all? do |attr|
        attr1 = service.send(attr.to_sym)
        attr2 = @service.send(attr.to_sym)
        attr1 == attr2
      end.must_equal true
    end
  end
end
