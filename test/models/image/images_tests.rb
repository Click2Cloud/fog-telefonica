require "test_helper"
describe "Fog::Image[:telefonica] | images" do
  before do
    @instance = Fog::Image[:telefonica].create_image(:name => "model test image").body
  end

  describe "success" do
    it "#find_by_id" do
      image = Fog::Image[:telefonica].images.find_by_id(@instance['image']['id'])
      image.id.must_equal @instance['image']['id']
    end

    it "#get" do
      image = Fog::Image[:telefonica].images.get(@instance['image']['id'])
      image.id.must_equal @instance['image']['id']
    end

    it "#destroy" do
      Fog::Image[:telefonica].images.destroy(@instance['image']['id']).must_equal true
    end
  end
end
