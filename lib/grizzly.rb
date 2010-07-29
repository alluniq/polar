require 'logger'
require 'grizzly/adapter'
require 'grizzly/errors'
require 'grizzly/groups'
require 'grizzly/permissions'
require 'grizzly/frameworks/rails'

module Grizzly

  class << self
    attr_accessor :logger    
  end
  
  def self.define(type)
    case type
    when :permissions
      yield(Grizzly::Permissions.define)
    when :groups
      yield(Grizzly::Groups.define)
    end
  end
  self.logger = Logger.new(STDOUT)
end