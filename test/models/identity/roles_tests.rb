require "test_helper"

describe "Fog::Identity[:telefonica] | roles" do
  before do
    @identity = Fog::Identity[:telefonica]

    @tenant   = @identity.tenants.create(:name => 'test_user')
    @user     = @identity.users.create(:name => 'test_user', :tenant_id => @tenant.id, :password => 'spoof')
    @role     = @identity.roles(:user => @user, :tenant => @tenant).create(:name => 'test_role')
    @roles    = @identity.roles(:user => @user, :tenant => @tenant)
  end

  after do
    @role.destroy
    @user.destroy
    @tenant.destroy
  end

  describe "success" do
    it "#all" do
      @roles.all.must_be_kind_of Fog::Identity::Telefonica::V2::Roles
    end

    it "#get" do
      @roles.get(@roles.first.id).body.wont_be_nil
    end
  end
end
