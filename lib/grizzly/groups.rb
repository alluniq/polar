module Grizzly
  module Groups
    class Base
      
      attr_writer :groups_store
      
      def self.define(&block)
        yield self if block_given?
        self
      end
      
      def self.method_missing(method, &block)
        yield GroupHash.new(method) if block_given?
      end
      
      def self.store
        unless @groups_store
          @groups_store = {}
        end
        @groups_store
      end
      
    end
    
    class GroupHash < Hash
      
      def initialize(method)
        self[:group_name] = method.to_sym
      end
      
      def have(*params)
        self[:params] = params
        Grizzly::Groups::Base.store[self[:group_name]] = self
      end
      
      def deny(*params)
        
      end
    end
  end
end