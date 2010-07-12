require File.expand_path(File.dirname(__FILE__) + '/permission')

module Grizzly
  class Storage
    def initialize(type, name, &block)
      yield self if block_given?
      self
    end
  end
end