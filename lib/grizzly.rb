require File.expand_path(File.dirname(__FILE__) + '/grizzly/logger')
require File.expand_path(File.dirname(__FILE__) + '/grizzly/configuration')

module Grizzly
  class << self
    attr_writer :configuration
  end

  def self.logger
    @logger || Grizzly.configuration.logger
  end
  
  def self.configuration
    @configuration ||= Configuration.new
  end
  
  def self.configure
    yield(self.configuration)
  end
end