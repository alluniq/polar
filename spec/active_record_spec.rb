require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Grizzly::ActiveRecordExtensions do
  before do
    @user = User.new
  end
  
  it "should respond to default" do
    User.should respond_to(:default)
  end
  
  it "should respond to owner" do
    User.should respond_to(:owner)
  end
  
end