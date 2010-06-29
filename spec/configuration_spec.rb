require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Grizzly::Configuration do
  after do
    Grizzly.configure do |config|
      config.logger = Grizzly::Logger.new('/dev/null')
    end
  end

  it 'should set the proper logger' do
    Grizzly.configure do |config|
      config.logger = Grizzly::Logger.new
    end

    Grizzly.logger.instance_variable_get(:@logdev).filename.should == nil
  end

end
