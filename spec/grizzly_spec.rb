require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Grizzly do
  before do
    @user = User.create
  end
  
  it "should respond to default" do
    User.should respond_to(:default)
  end
  
  it "should respond to owner" do
    User.should respond_to(:owner)
  end

  it "should return default permissions for user" do
    @user.permissions
  end  
  
  it "should check if user is a member of specific group" do
    @user.member_of?(:clients).should be(true)
  end
  
  it "should return true if user is a member of a group stored in database" do
    UserGroup.create(:user_id => @user.id, :group_name => "test_group")
    UserGroup.create(:user_id => @user.id, :group_name => "another_group")
    @user.member_of?(:test_group).should be(true)
  end
  
  it "should check and return false if user is NOT a member of specific group" do
    @user.member_of?(:not_existing_group).should be(false)
  end
  
  it "should check if user has specific permission" do
    @user.can?(:edit_profile).should be(true)    
  end
  
  it "should return false for permission NOT assigned for specific, even in database" do
    @user.can?(:add_addresses).should be(false)
  end
  
  it "should return true for permission assigned for specific user in database" do
    UserPermission.create(:user_id => @user.id, :permission_name => "add_addresses")
    @user.can?(:add_addresses).should be(true)
  end
  
  it "should return false if user DO NOT have specific permission" do
    lambda { 
      @user.can?(:do_something_that_doesnt_exist)
    }.should raise_error(Grizzly::PermissionNotDefined)
  end
  
end

