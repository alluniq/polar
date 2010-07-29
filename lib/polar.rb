require 'logger'
require 'polar/adapter'
require 'polar/errors'
require 'polar/groups'
require 'polar/permissions'
require 'polar/frameworks/rails'

module Polar

  class << self
    attr_accessor :logger    
  end
  
  def self.define(type)
    case type
    when :permissions
      yield(Polar::Permissions.define)
    when :groups
      yield(Polar::Groups.define)
    end
  end
  self.logger = Logger.new(STDOUT)
end