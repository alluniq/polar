require File.expand_path(File.dirname(__FILE__) + '/grizzly/adapter')
require 'logger'

module Grizzly
  
  autoload :Permissions,                                'grizzly/permissions'
  autoload :Groups,                                     'grizzly/groups'
  
  autoload :PermissionNotDefinedButSetAsDefault,        'grizzly/errors'
  autoload :PermissionNotDefined,                       'grizzly/errors'
  
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