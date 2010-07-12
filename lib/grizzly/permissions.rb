require File.expand_path(File.dirname(__FILE__) + '/storage')

module Grizzly
  module Permissions
    class Base
      
      attr_writer :permissions_store
      
      def self.define(&block)
        yield self if block_given?
        self
      end
      
      def self.method_missing(method, &block)
        yield PermissionHash.new(method) if block_given?
      end
      
      def self.store
        unless @permissions_store
          @permissions_store = []
        end
        @permissions_store
      end
      
    end
    
    class PermissionHash
      attr_accessor :auth_type
      attr_accessor :params
      
      def initialize(method)
        @auth_type = method.to_sym
      end
      
      def allow(*params)
        Grizzly::Permissions::Base.store << self
        @params = params
      end
      
      def deny(*params)
        
      end
    end
  end
end